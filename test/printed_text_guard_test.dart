import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:grafometria/src/features/analyzer/application/printed_text_guard.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

void main() {
  group('PrintedTextHeuristics', () {
    test('flags regular printed paragraphs', () {
      final inspection = PrintedTextHeuristics.classify(
        RecognizedText(
          text: 'ARIAL PRINTED SAMPLE\nONLY PRINTED TEXT',
          blocks: [
            _block(
              text: 'ARIAL PRINTED SAMPLE\nONLY PRINTED TEXT',
              rect: const Rect.fromLTWH(10, 10, 280, 82),
              lines: [
                _line(
                  text: 'ARIAL PRINTED SAMPLE',
                  rect: const Rect.fromLTWH(10, 10, 280, 28),
                  confidence: 0.96,
                  elements: [
                    _elementWord('ARIAL', 10, 10, confidence: 0.97),
                    _elementWord('PRINTED', 98, 10, confidence: 0.96),
                    _elementWord('SAMPLE', 214, 10, confidence: 0.94),
                  ],
                ),
                _line(
                  text: 'ONLY PRINTED TEXT',
                  rect: const Rect.fromLTWH(10, 56, 244, 28),
                  confidence: 0.95,
                  elements: [
                    _elementWord('ONLY', 10, 56, confidence: 0.95),
                    _elementWord('PRINTED', 88, 56, confidence: 0.94),
                    _elementWord('TEXT', 204, 56, confidence: 0.93),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      expect(inspection.isLikelyPrinted, isTrue);
      expect(inspection.score, greaterThan(0.68));
    });

    test('flags close-up printed words with regular symbols', () {
      final inspection = PrintedTextHeuristics.classify(
        RecognizedText(
          text: 'ARIAL',
          blocks: [
            _block(
              text: 'ARIAL',
              rect: const Rect.fromLTWH(20, 20, 180, 54),
              lines: [
                _line(
                  text: 'ARIAL',
                  rect: const Rect.fromLTWH(20, 20, 180, 54),
                  confidence: 0.94,
                  elements: [
                    _elementWord(
                      'ARIAL',
                      20,
                      20,
                      confidence: 0.95,
                      symbolWidth: 28,
                      symbolHeight: 52,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      expect(inspection.isLikelyPrinted, isTrue);
    });

    test('does not flag irregular low-confidence handwriting-like OCR', () {
      final inspection = PrintedTextHeuristics.classify(
        RecognizedText(
          text: 'ciao come stai',
          blocks: [
            _block(
              text: 'ciao come stai',
              rect: const Rect.fromLTWH(10, 20, 260, 96),
              lines: [
                _line(
                  text: 'ciao come stai',
                  rect: const Rect.fromLTWH(10, 20, 260, 96),
                  confidence: 0.58,
                  angle: 7.0,
                  elements: [
                    _elementWord(
                      'ciao',
                      10,
                      24,
                      confidence: 0.54,
                      symbolWidth: 19,
                      symbolHeight: 34,
                      perSymbolHeightDeltas: const [0, 8, -6, 12],
                      perSymbolWidthDeltas: const [0, 4, -3, 5],
                      perSymbolYOffset: const [0, 6, -5, 8],
                    ),
                    _elementWord(
                      'come',
                      96,
                      20,
                      confidence: 0.52,
                      symbolWidth: 20,
                      symbolHeight: 38,
                      perSymbolHeightDeltas: const [4, -3, 9, -5],
                      perSymbolWidthDeltas: const [3, -2, 5, -4],
                      perSymbolYOffset: const [2, -5, 7, -3],
                    ),
                    _elementWord(
                      'stai',
                      180,
                      42,
                      confidence: 0.50,
                      angle: 10.0,
                      symbolWidth: 18,
                      symbolHeight: 32,
                      perSymbolHeightDeltas: const [-3, 6, -4, 9],
                      perSymbolWidthDeltas: const [-2, 5, -3, 4],
                      perSymbolYOffset: const [8, -4, 6, -2],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      expect(inspection.isLikelyPrinted, isFalse);
      expect(inspection.recognitionConfidence, lessThan(0.7));
    });
  });
}

TextBlock _block({
  required String text,
  required Rect rect,
  required List<TextLine> lines,
}) {
  return TextBlock(
    text: text,
    lines: lines,
    boundingBox: rect,
    recognizedLanguages: const ['it'],
    cornerPoints: _corners(rect),
  );
}

TextLine _line({
  required String text,
  required Rect rect,
  required List<TextElement> elements,
  double? confidence,
  double? angle,
}) {
  return TextLine(
    text: text,
    elements: elements,
    boundingBox: rect,
    recognizedLanguages: const ['it'],
    cornerPoints: _corners(rect),
    confidence: confidence,
    angle: angle,
  );
}

TextElement _elementWord(
  String text,
  double left,
  double top, {
  required double confidence,
  double angle = 0,
  double symbolWidth = 22,
  double symbolHeight = 34,
  List<double>? perSymbolWidthDeltas,
  List<double>? perSymbolHeightDeltas,
  List<double>? perSymbolYOffset,
}) {
  final symbols = <TextSymbol>[];
  var cursor = left;

  for (var index = 0; index < text.length; index++) {
    final widthDelta = perSymbolWidthDeltas?[index] ?? 0;
    final heightDelta = perSymbolHeightDeltas?[index] ?? 0;
    final yOffset = perSymbolYOffset?[index] ?? 0;
    final rect = Rect.fromLTWH(
      cursor,
      top + yOffset,
      symbolWidth + widthDelta,
      symbolHeight + heightDelta,
    );
    symbols.add(
      TextSymbol(
        text: text[index],
        boundingBox: rect,
        recognizedLanguages: const ['it'],
        cornerPoints: _corners(rect),
        confidence: confidence,
        angle: angle,
      ),
    );
    cursor += rect.width + 4;
  }

  final right = symbols.last.boundingBox.right;
  final bottom = symbols
      .map((symbol) => symbol.boundingBox.bottom)
      .reduce(math.max);
  final topMost = symbols
      .map((symbol) => symbol.boundingBox.top)
      .reduce(math.min);
  final rect = Rect.fromLTRB(left, topMost, right, bottom);

  return TextElement(
    text: text,
    symbols: symbols,
    boundingBox: rect,
    recognizedLanguages: const ['it'],
    cornerPoints: _corners(rect),
    confidence: confidence,
    angle: angle,
  );
}

List<math.Point<int>> _corners(Rect rect) {
  return [
    math.Point<int>(rect.left.round(), rect.top.round()),
    math.Point<int>(rect.right.round(), rect.top.round()),
    math.Point<int>(rect.right.round(), rect.bottom.round()),
    math.Point<int>(rect.left.round(), rect.bottom.round()),
  ];
}
