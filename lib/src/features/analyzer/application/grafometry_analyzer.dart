import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import '../domain/writer_profile.dart';

const _unsupportedImageFormatMessage = 'Unsupported image format.';
const _imageTooSmallMessage =
    'Image too small. Capture a closer and sharper photo.';
const _notEnoughHandwritingMessage =
    'Not enough handwriting detected. Try with better framing.';
const _handwritingRequiredMessage = 'Photograph handwritten text and retry.';

class GrafometryAnalyzer {
  Future<WriterProfile> analyze(Uint8List imageBytes) async {
    final profileMap = await compute(_analyzeImageBytes, imageBytes);
    return WriterProfile.fromJson(profileMap);
  }
}

Map<String, double> _analyzeImageBytes(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw const FormatException(_unsupportedImageFormatMessage);
  }

  final targetWidth = decoded.width > 384 ? 384 : decoded.width;
  final resized = img.copyResize(decoded, width: targetWidth);
  final gray = img.grayscale(resized);

  final width = gray.width;
  final height = gray.height;
  final totalPixels = width * height;

  if (totalPixels < 10_000) {
    throw const FormatException(_imageTooSmallMessage);
  }

  final histogram = List<int>.filled(256, 0);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final lum = gray.getPixel(x, y).r.toInt();
      histogram[lum]++;
    }
  }

  final luminanceStats = _computeLuminanceStats(histogram, totalPixels);
  if (luminanceStats.isLowInformationFrame) {
    throw const FormatException(_handwritingRequiredMessage);
  }

  final threshold = _otsuThreshold(histogram, totalPixels);
  final ink = List<Uint8List>.generate(height, (_) => Uint8List(width));

  var inkPixels = 0;
  var inkLumaSum = 0.0;

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final lum = gray.getPixel(x, y).r.toInt();
      if (lum <= threshold) {
        ink[y][x] = 1;
        inkPixels++;
        inkLumaSum += lum;
      }
    }
  }

  final inkRatio = inkPixels / totalPixels;
  final rowInkCoverage = _computeRowInkCoverage(ink, width, height);
  final handwritingStats = _computeHandwritingStats(ink, width, height);

  if (inkRatio < 0.01) {
    if (handwritingStats.isLikelySparsePrintedText) {
      throw const FormatException(_handwritingRequiredMessage);
    }
    throw const FormatException(_notEnoughHandwritingMessage);
  }

  if (inkRatio > 0.42) {
    throw const FormatException(_handwritingRequiredMessage);
  }

  if (rowInkCoverage > 0.82 && inkRatio > 0.24) {
    throw const FormatException(_handwritingRequiredMessage);
  }

  if (handwritingStats.isLikelyNonHandwriting) {
    throw const FormatException(_handwritingRequiredMessage);
  }

  final columnInk = List<int>.filled(width, 0);
  final columnCentersX = <double>[];
  final columnCentersY = <double>[];
  final columnHeights = <double>[];

  for (var x = 0; x < width; x++) {
    var count = 0;
    var sumY = 0.0;
    var top = height;
    var bottom = -1;

    for (var y = 0; y < height; y++) {
      if (ink[y][x] == 1) {
        count++;
        sumY += y;
        if (y < top) {
          top = y;
        }
        if (y > bottom) {
          bottom = y;
        }
      }
    }

    columnInk[x] = count;
    if (count > 0) {
      columnCentersX.add(x.toDouble());
      columnCentersY.add(sumY / count);
      columnHeights.add((bottom - top + 1).toDouble());
    }
  }

  final baselineAngle = _computeBaselineAngle(columnCentersX, columnCentersY);
  final slantAngle = _computeSlantAngle(ink, width, height);
  final pressureIndex = _computePressureIndex(
    inkRatio: inkRatio,
    inkLumaSum: inkLumaSum,
    inkPixels: inkPixels,
  );
  final spacingRatio = _computeSpacingRatio(columnInk);
  final letterSizeVariance = _coefficientOfVariation(columnHeights);
  final penLiftFrequency = _computePenLiftFrequency(ink, width, height);
  final contrastIndex = _computeContrastIndex(histogram, totalPixels);
  final sharpnessIndex = _computeSharpnessIndex(gray, width, height);
  final coverageIndex = _computeCoverageIndex(inkRatio);
  final confidenceScore = _computeConfidence(
    inkRatio: inkRatio,
    nonEmptyColumns: columnCentersX.length,
    width: width,
  );
  final qualityGateScore = _computeQualityGateScore(
    coverageIndex: coverageIndex,
    contrastIndex: contrastIndex,
    sharpnessIndex: sharpnessIndex,
  );

  return <String, double>{
    'baselineAngle': baselineAngle,
    'slantAngle': slantAngle,
    'pressureIndex': pressureIndex,
    'spacingRatio': spacingRatio,
    'letterSizeVariance': letterSizeVariance,
    'penLiftFrequency': penLiftFrequency,
    'confidenceScore': confidenceScore,
    'contrastIndex': contrastIndex,
    'sharpnessIndex': sharpnessIndex,
    'coverageIndex': coverageIndex,
    'qualityGateScore': qualityGateScore,
  };
}

int _otsuThreshold(List<int> histogram, int totalPixels) {
  var weightedSum = 0.0;
  for (var i = 0; i < 256; i++) {
    weightedSum += i * histogram[i];
  }

  var maxVariance = -1.0;
  var threshold = 127;
  var backgroundWeight = 0;
  var backgroundSum = 0.0;

  for (var i = 0; i < 256; i++) {
    backgroundWeight += histogram[i];
    if (backgroundWeight == 0) {
      continue;
    }

    final foregroundWeight = totalPixels - backgroundWeight;
    if (foregroundWeight == 0) {
      break;
    }

    backgroundSum += i * histogram[i];

    final backgroundMean = backgroundSum / backgroundWeight;
    final foregroundMean = (weightedSum - backgroundSum) / foregroundWeight;
    final delta = backgroundMean - foregroundMean;
    final variance = backgroundWeight * foregroundWeight * delta * delta;

    if (variance > maxVariance) {
      maxVariance = variance;
      threshold = i;
    }
  }

  return threshold;
}

_LuminanceStats _computeLuminanceStats(List<int> histogram, int totalPixels) {
  if (totalPixels <= 0) {
    return const _LuminanceStats(mean: 0, stdDev: 0, dynamicRange: 0);
  }

  var mean = 0.0;
  for (var i = 0; i < histogram.length; i++) {
    mean += i * histogram[i];
  }
  mean /= totalPixels;

  var variance = 0.0;
  for (var i = 0; i < histogram.length; i++) {
    final delta = i - mean;
    variance += delta * delta * histogram[i];
  }
  variance /= totalPixels;

  var low = 0;
  while (low < histogram.length && histogram[low] == 0) {
    low++;
  }

  var high = histogram.length - 1;
  while (high >= 0 && histogram[high] == 0) {
    high--;
  }

  final dynamicRange = high < low ? 0.0 : (high - low).toDouble();

  return _LuminanceStats(
    mean: mean,
    stdDev: math.sqrt(variance),
    dynamicRange: dynamicRange,
  );
}

double _computeRowInkCoverage(List<Uint8List> ink, int width, int height) {
  if (height == 0) {
    return 0.0;
  }

  var rowsWithInk = 0;
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (ink[y][x] == 1) {
        rowsWithInk++;
        break;
      }
    }
  }

  return rowsWithInk / height;
}

_HandwritingStats _computeHandwritingStats(
  List<Uint8List> ink,
  int width,
  int height,
) {
  if (width <= 0 || height <= 0) {
    return const _HandwritingStats.empty();
  }

  final visited = List<Uint8List>.generate(height, (_) => Uint8List(width));
  final components = <_InkComponent>[];

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (ink[y][x] == 0 || visited[y][x] == 1) {
        continue;
      }

      final queue = <int>[y * width + x];
      visited[y][x] = 1;
      var head = 0;
      var area = 0;
      var minX = x;
      var maxX = x;
      var minY = y;
      var maxY = y;

      while (head < queue.length) {
        final index = queue[head++];
        final currentX = index % width;
        final currentY = index ~/ width;

        area++;
        if (currentX < minX) {
          minX = currentX;
        }
        if (currentX > maxX) {
          maxX = currentX;
        }
        if (currentY < minY) {
          minY = currentY;
        }
        if (currentY > maxY) {
          maxY = currentY;
        }

        for (var dy = -1; dy <= 1; dy++) {
          for (var dx = -1; dx <= 1; dx++) {
            if (dx == 0 && dy == 0) {
              continue;
            }
            final nextX = currentX + dx;
            final nextY = currentY + dy;
            if (nextX < 0 ||
                nextX >= width ||
                nextY < 0 ||
                nextY >= height ||
                ink[nextY][nextX] == 0 ||
                visited[nextY][nextX] == 1) {
              continue;
            }
            visited[nextY][nextX] = 1;
            queue.add(nextY * width + nextX);
          }
        }
      }

      final componentWidth = maxX - minX + 1;
      final componentHeight = maxY - minY + 1;
      if (area >= 8 && componentWidth >= 2 && componentHeight >= 2) {
        components.add(
          _InkComponent(
            area: area,
            width: componentWidth,
            height: componentHeight,
          ),
        );
      }
    }
  }

  if (components.isEmpty) {
    return const _HandwritingStats.empty();
  }

  final componentHeights = <double>[];
  final componentFillRatios = <double>[];
  var smallComponents = 0;
  var wideComponents = 0;
  for (final component in components) {
    componentHeights.add(component.height.toDouble());
    componentFillRatios.add(component.fillRatio);
    if (component.area < 30 || component.height < 6) {
      smallComponents++;
    }
    if (component.aspectRatio >= 1.35) {
      wideComponents++;
    }
  }

  var horizontalLinks = 0;
  var verticalLinks = 0;
  var diagonalLinks = 0;
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      if (ink[y][x] == 0) {
        continue;
      }
      if (x + 1 < width && ink[y][x + 1] == 1) {
        horizontalLinks++;
      }
      if (y + 1 < height && ink[y + 1][x] == 1) {
        verticalLinks++;
      }
      if (x + 1 < width && y + 1 < height && ink[y + 1][x + 1] == 1) {
        diagonalLinks++;
      }
      if (x > 0 && y + 1 < height && ink[y + 1][x - 1] == 1) {
        diagonalLinks++;
      }
    }
  }

  final totalLinks = horizontalLinks + verticalLinks + diagonalLinks;
  final diagonalShare = totalLinks == 0 ? 0.0 : diagonalLinks / totalLinks;
  final heightVariation = _coefficientOfVariation(componentHeights);
  final fillVariation = _coefficientOfVariation(componentFillRatios);
  final smallComponentRatio = smallComponents / components.length;
  final wideComponentRatio = wideComponents / components.length;
  final handwritingScore =
      (heightVariation / 0.35).clamp(0.0, 1.0) * 0.32 +
      (fillVariation / 0.30).clamp(0.0, 1.0) * 0.22 +
      wideComponentRatio.clamp(0.0, 1.0) * 0.18 +
      (diagonalShare / 0.26).clamp(0.0, 1.0) * 0.18 +
      (1.0 - smallComponentRatio).clamp(0.0, 1.0) * 0.10;

  return _HandwritingStats(
    componentCount: components.length,
    handwritingScore: handwritingScore,
    heightVariation: heightVariation,
    fillVariation: fillVariation,
    diagonalShare: diagonalShare,
    smallComponentRatio: smallComponentRatio,
    wideComponentRatio: wideComponentRatio,
  );
}

double _computeBaselineAngle(List<double> x, List<double> y) {
  if (x.length < 3 || y.length < 3) {
    return 0;
  }

  final n = x.length.toDouble();
  var sumX = 0.0;
  var sumY = 0.0;
  var sumXY = 0.0;
  var sumXX = 0.0;

  for (var i = 0; i < x.length; i++) {
    sumX += x[i];
    sumY += y[i];
    sumXY += x[i] * y[i];
    sumXX += x[i] * x[i];
  }

  final denominator = (n * sumXX - sumX * sumX).abs() < 1e-9
      ? 1e-9
      : (n * sumXX - sumX * sumX);
  final slope = (n * sumXY - sumX * sumY) / denominator;
  final angle = -math.atan(slope) * 180 / math.pi;
  return angle.clamp(-12.0, 12.0);
}

double _computeSlantAngle(List<Uint8List> ink, int width, int height) {
  var rightLinks = 0;
  var leftLinks = 0;

  for (var y = 1; y < height - 1; y++) {
    for (var x = 1; x < width - 1; x++) {
      if (ink[y][x] == 0) {
        continue;
      }

      if (ink[y + 1][x + 1] == 1 || ink[y - 1][x + 1] == 1) {
        rightLinks++;
      }
      if (ink[y + 1][x - 1] == 1 || ink[y - 1][x - 1] == 1) {
        leftLinks++;
      }
    }
  }

  final totalLinks = rightLinks + leftLinks;
  if (totalLinks == 0) {
    return 0;
  }

  final score = (rightLinks - leftLinks) / totalLinks;
  return (score * 22.0).clamp(-22.0, 22.0);
}

double _computePressureIndex({
  required double inkRatio,
  required double inkLumaSum,
  required int inkPixels,
}) {
  final avgInkLuma = inkPixels == 0 ? 255.0 : inkLumaSum / inkPixels;
  final darknessScore = 1.0 - (avgInkLuma / 255.0);
  final weighted = (inkRatio * 1.6) + (darknessScore * 0.9);
  return (weighted / 2.2).clamp(0.0, 1.0);
}

double _computeSpacingRatio(List<int> columnInk) {
  final strokeRuns = <int>[];
  final gapRuns = <int>[];

  var currentRun = 0;
  var inInk = columnInk.first > 0;

  for (final value in columnInk) {
    final isInk = value > 0;
    if (isInk == inInk) {
      currentRun++;
    } else {
      if (inInk) {
        strokeRuns.add(currentRun);
      } else {
        gapRuns.add(currentRun);
      }
      inInk = isInk;
      currentRun = 1;
    }
  }

  if (currentRun > 0) {
    if (inInk) {
      strokeRuns.add(currentRun);
    } else {
      gapRuns.add(currentRun);
    }
  }

  final validGaps = gapRuns.where((gap) => gap > 1).toList();
  if (strokeRuns.isEmpty || validGaps.isEmpty) {
    return 0.6;
  }

  final avgStroke = strokeRuns.reduce((a, b) => a + b) / strokeRuns.length;
  final avgGap = validGaps.reduce((a, b) => a + b) / validGaps.length;
  return (avgGap / avgStroke).clamp(0.4, 2.4);
}

double _coefficientOfVariation(List<double> values) {
  if (values.length < 2) {
    return 0.1;
  }

  final mean = values.reduce((a, b) => a + b) / values.length;
  if (mean == 0) {
    return 0.1;
  }

  var squareDiffSum = 0.0;
  for (final value in values) {
    final diff = value - mean;
    squareDiffSum += diff * diff;
  }

  final stdDev = math.sqrt(squareDiffSum / values.length);
  return (stdDev / mean).clamp(0.0, 1.0);
}

double _computePenLiftFrequency(List<Uint8List> ink, int width, int height) {
  var transitions = 0;

  for (var y = 0; y < height; y++) {
    var previous = ink[y][0] == 1;
    for (var x = 1; x < width; x++) {
      final current = ink[y][x] == 1;
      if (current != previous) {
        transitions++;
        previous = current;
      }
    }
  }

  final maxTransitions = height * (width - 1);
  if (maxTransitions == 0) {
    return 0.0;
  }

  final normalized = (transitions / maxTransitions) * 4.8;
  return normalized.clamp(0.0, 1.0);
}

double _computeConfidence({
  required double inkRatio,
  required int nonEmptyColumns,
  required int width,
}) {
  final coverage = ((inkRatio - 0.015) / 0.17).clamp(0.0, 1.0);
  final structure = (nonEmptyColumns / width).clamp(0.0, 1.0);
  return (coverage * 0.6 + structure * 0.4).clamp(0.0, 1.0);
}

double _computeCoverageIndex(double inkRatio) {
  return ((inkRatio - 0.015) / 0.17).clamp(0.0, 1.0);
}

double _computeContrastIndex(List<int> histogram, int totalPixels) {
  if (totalPixels <= 0) {
    return 0.0;
  }
  var mean = 0.0;
  for (var i = 0; i < histogram.length; i++) {
    mean += i * histogram[i];
  }
  mean /= totalPixels;

  var variance = 0.0;
  for (var i = 0; i < histogram.length; i++) {
    final delta = i - mean;
    variance += delta * delta * histogram[i];
  }
  variance /= totalPixels;
  final stdDev = math.sqrt(variance);
  return (stdDev / 64.0).clamp(0.0, 1.0);
}

double _computeSharpnessIndex(img.Image gray, int width, int height) {
  if (width < 3 || height < 3) {
    return 0.0;
  }
  var edgeSum = 0.0;
  var count = 0;
  for (var y = 1; y < height - 1; y++) {
    for (var x = 1; x < width - 1; x++) {
      final center = gray.getPixel(x, y).r.toDouble();
      final right = gray.getPixel(x + 1, y).r.toDouble();
      final down = gray.getPixel(x, y + 1).r.toDouble();
      edgeSum += (center - right).abs() + (center - down).abs();
      count++;
    }
  }
  if (count == 0) {
    return 0.0;
  }
  final meanEdge = edgeSum / count;
  return (meanEdge / 50.0).clamp(0.0, 1.0);
}

double _computeQualityGateScore({
  required double coverageIndex,
  required double contrastIndex,
  required double sharpnessIndex,
}) {
  return (coverageIndex * 0.45 + contrastIndex * 0.25 + sharpnessIndex * 0.30)
      .clamp(0.0, 1.0);
}

class _LuminanceStats {
  const _LuminanceStats({
    required this.mean,
    required this.stdDev,
    required this.dynamicRange,
  });

  final double mean;
  final double stdDev;
  final double dynamicRange;

  bool get isLowInformationFrame {
    final tooUniform = dynamicRange < 28;
    final tooDark = mean < 36 && dynamicRange < 52;
    return tooUniform || tooDark;
  }
}

class _InkComponent {
  const _InkComponent({
    required this.area,
    required this.width,
    required this.height,
  });

  final int area;
  final int width;
  final int height;

  double get aspectRatio => width / math.max(1, height);

  double get fillRatio => area / math.max(1, width * height);
}

class _HandwritingStats {
  const _HandwritingStats({
    required this.componentCount,
    required this.handwritingScore,
    required this.heightVariation,
    required this.fillVariation,
    required this.diagonalShare,
    required this.smallComponentRatio,
    required this.wideComponentRatio,
  });

  const _HandwritingStats.empty()
    : componentCount = 0,
      handwritingScore = 0,
      heightVariation = 0,
      fillVariation = 0,
      diagonalShare = 0,
      smallComponentRatio = 1,
      wideComponentRatio = 0;

  final int componentCount;
  final double handwritingScore;
  final double heightVariation;
  final double fillVariation;
  final double diagonalShare;
  final double smallComponentRatio;
  final double wideComponentRatio;

  bool get isLikelyNonHandwriting {
    if (componentCount == 0) {
      return true;
    }

    if (componentCount >= 8 && handwritingScore < 0.48) {
      return true;
    }

    if (componentCount >= 10 &&
        heightVariation < 0.26 &&
        diagonalShare < 0.22 &&
        wideComponentRatio < 0.45) {
      return true;
    }

    if (componentCount >= 20 &&
        heightVariation < 0.10 &&
        wideComponentRatio < 0.12) {
      return true;
    }

    return componentCount >= 5 &&
        heightVariation < 0.18 &&
        fillVariation < 0.18 &&
        diagonalShare < 0.16 &&
        wideComponentRatio < 0.32 &&
        smallComponentRatio > 0.42;
  }

  bool get isLikelySparsePrintedText {
    if (componentCount < 3 || componentCount > 12) {
      return false;
    }

    return heightVariation < 0.18 &&
        fillVariation < 0.48 &&
        wideComponentRatio < 0.20 &&
        smallComponentRatio < 0.75;
  }
}
