import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class PrintedTextInspection {
  const PrintedTextInspection({
    required this.isLikelyPrinted,
    required this.score,
    required this.recognitionConfidence,
    required this.alphanumericCount,
    required this.lineCount,
    required this.elementCount,
  });

  const PrintedTextInspection.none()
    : isLikelyPrinted = false,
      score = 0,
      recognitionConfidence = 0,
      alphanumericCount = 0,
      lineCount = 0,
      elementCount = 0;

  final bool isLikelyPrinted;
  final double score;
  final double recognitionConfidence;
  final int alphanumericCount;
  final int lineCount;
  final int elementCount;
}

abstract class PrintedTextGuard {
  Future<PrintedTextInspection> inspect(String imagePath);

  Future<void> close();
}

class MlKitPrintedTextGuard implements PrintedTextGuard {
  MlKitPrintedTextGuard({TextRecognizer? recognizer})
    : _recognizer =
          recognizer ?? TextRecognizer(script: TextRecognitionScript.latin);

  final TextRecognizer _recognizer;

  @override
  Future<PrintedTextInspection> inspect(String imagePath) async {
    if (imagePath.isEmpty ||
        kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return const PrintedTextInspection.none();
    }

    final recognizedText = await _recognizer.processImage(
      InputImage.fromFilePath(imagePath),
    );
    return PrintedTextHeuristics.classify(recognizedText);
  }

  @override
  Future<void> close() => _recognizer.close();
}

class PrintedTextHeuristics {
  static PrintedTextInspection classify(RecognizedText recognizedText) {
    final compactText = recognizedText.text.replaceAll(RegExp(r'\s+'), '');
    final alphanumericCount = RegExp(
      r'[A-Za-z0-9À-ÖØ-öø-ÿ]',
    ).allMatches(compactText).length;
    final lines = recognizedText.blocks.expand((block) => block.lines).toList();
    final elements = lines.expand((line) => line.elements).toList();
    final symbols = elements.expand((element) => element.symbols).toList();

    if (alphanumericCount < 4 || lines.isEmpty || elements.isEmpty) {
      return const PrintedTextInspection.none();
    }

    final elementHeights = elements
        .map((element) => element.boundingBox.height)
        .where((height) => height > 0)
        .toList();
    final elementWidths = elements
        .map((element) => element.boundingBox.width)
        .where((width) => width > 0)
        .toList();
    final symbolHeights = symbols
        .map((symbol) => symbol.boundingBox.height)
        .where((height) => height > 0)
        .toList();
    final symbolWidths = symbols
        .map((symbol) => symbol.boundingBox.width)
        .where((width) => width > 0)
        .toList();

    final elementHeightCv = _coefficientOfVariation(elementHeights);
    final elementWidthCv = _coefficientOfVariation(elementWidths);
    final symbolHeightCv = _coefficientOfVariation(symbolHeights);
    final symbolWidthCv = _coefficientOfVariation(symbolWidths);
    final baselineJitter = _baselineJitter(lines);
    final meanAngleAbs = _meanAbsoluteAngles(lines, elements, symbols);
    final recognitionConfidence = _recognitionConfidence(
      lines,
      elements,
      symbols,
    );

    final textEvidence = (alphanumericCount / 14).clamp(0.0, 1.0) * 0.22;
    final geometryEvidence =
        (1 - (elementHeightCv / 0.24)).clamp(0.0, 1.0) * 0.18 +
        (1 - (elementWidthCv / 0.38)).clamp(0.0, 1.0) * 0.10 +
        (1 - (symbolHeightCv / 0.18)).clamp(0.0, 1.0) * 0.10 +
        (1 - (symbolWidthCv / 0.28)).clamp(0.0, 1.0) * 0.10;
    final alignmentEvidence =
        (1 - (baselineJitter / 0.18)).clamp(0.0, 1.0) * 0.20 +
        (1 - (meanAngleAbs / 10)).clamp(0.0, 1.0) * 0.10;
    final confidenceEvidence =
        ((recognitionConfidence - 0.58) / 0.30).clamp(0.0, 1.0) * 0.20;

    final score =
        (textEvidence +
                geometryEvidence +
                alignmentEvidence +
                confidenceEvidence)
            .clamp(0.0, 1.0);

    final strongPrintedParagraph =
        alphanumericCount >= 8 &&
        elements.length >= 3 &&
        recognitionConfidence >= 0.72 &&
        elementHeightCv < 0.20 &&
        baselineJitter < 0.18 &&
        meanAngleAbs < 8;

    final strongPrintedCloseup =
        alphanumericCount >= 5 &&
        symbols.length >= 5 &&
        recognitionConfidence >= 0.84 &&
        symbolHeightCv < 0.12 &&
        symbolWidthCv < 0.18 &&
        meanAngleAbs < 5;

    final isLikelyPrinted =
        (score >= 0.68 && recognitionConfidence >= 0.68) ||
        strongPrintedParagraph ||
        strongPrintedCloseup;

    return PrintedTextInspection(
      isLikelyPrinted: isLikelyPrinted,
      score: score,
      recognitionConfidence: recognitionConfidence,
      alphanumericCount: alphanumericCount,
      lineCount: lines.length,
      elementCount: elements.length,
    );
  }

  static double _recognitionConfidence(
    List<TextLine> lines,
    List<TextElement> elements,
    List<TextSymbol> symbols,
  ) {
    final symbolConfidence = _mean(
      symbols.map((symbol) => symbol.confidence).nonNulls,
    );
    final elementConfidence = _mean(
      elements.map((element) => element.confidence).nonNulls,
    );
    final lineConfidence = _mean(lines.map((line) => line.confidence).nonNulls);

    if (symbolConfidence > 0) {
      return (symbolConfidence * 0.55 +
              elementConfidence * 0.30 +
              lineConfidence * 0.15)
          .clamp(0.0, 1.0);
    }

    if (elementConfidence > 0) {
      return (elementConfidence * 0.70 + lineConfidence * 0.30).clamp(0.0, 1.0);
    }

    return lineConfidence.clamp(0.0, 1.0);
  }

  static double _baselineJitter(List<TextLine> lines) {
    final jitters = <double>[];

    for (final line in lines) {
      final carriers = <Rect>[
        for (final element in line.elements)
          if (element.symbols.isNotEmpty) ...[
            for (final symbol in element.symbols) symbol.boundingBox,
          ] else
            element.boundingBox,
      ];

      if (carriers.length < 2) {
        continue;
      }

      final meanBottom =
          carriers.map((rect) => rect.bottom).reduce((a, b) => a + b) /
          carriers.length;
      final meanHeight =
          carriers.map((rect) => rect.height).reduce((a, b) => a + b) /
          carriers.length;
      if (meanHeight <= 0) {
        continue;
      }

      final meanDeviation =
          carriers
              .map((rect) => (rect.bottom - meanBottom).abs())
              .reduce((a, b) => a + b) /
          carriers.length;
      jitters.add(meanDeviation / meanHeight);
    }

    return _mean(jitters);
  }

  static double _meanAbsoluteAngles(
    List<TextLine> lines,
    List<TextElement> elements,
    List<TextSymbol> symbols,
  ) {
    final angles = <double>[
      ...lines.map((line) => line.angle).nonNulls.map((angle) => angle.abs()),
      ...elements
          .map((element) => element.angle)
          .nonNulls
          .map((angle) => angle.abs()),
      ...symbols
          .map((symbol) => symbol.angle)
          .nonNulls
          .map((angle) => angle.abs()),
    ];
    return _mean(angles);
  }

  static double _mean(Iterable<double> values) {
    final list = values.toList();
    if (list.isEmpty) {
      return 0.0;
    }
    return list.reduce((a, b) => a + b) / list.length;
  }

  static double _coefficientOfVariation(List<double> values) {
    if (values.length < 2) {
      return 0.0;
    }

    final mean = _mean(values);
    if (mean.abs() < 1e-9) {
      return 0.0;
    }

    var squareDiffSum = 0.0;
    for (final value in values) {
      final delta = value - mean;
      squareDiffSum += delta * delta;
    }

    return math.sqrt(squareDiffSum / values.length) / mean.abs();
  }
}
