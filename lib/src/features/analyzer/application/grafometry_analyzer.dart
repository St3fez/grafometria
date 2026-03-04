import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import '../domain/writer_profile.dart';

class GrafometryAnalyzer {
  Future<WriterProfile> analyze(Uint8List imageBytes) async {
    final profileMap = await compute(_analyzeImageBytes, imageBytes);
    return WriterProfile.fromJson(profileMap);
  }
}

Map<String, double> _analyzeImageBytes(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) {
    throw const FormatException('Unsupported image format.');
  }

  final targetWidth = decoded.width > 384 ? 384 : decoded.width;
  final resized = img.copyResize(decoded, width: targetWidth);
  final gray = img.grayscale(resized);

  final width = gray.width;
  final height = gray.height;
  final totalPixels = width * height;

  if (totalPixels < 10_000) {
    throw const FormatException(
      'Image too small. Capture a closer and sharper photo.',
    );
  }

  final histogram = List<int>.filled(256, 0);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final lum = gray.getPixel(x, y).r.toInt();
      histogram[lum]++;
    }
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
  if (inkRatio < 0.01) {
    throw const FormatException(
      'Not enough handwriting detected. Try with better framing.',
    );
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
