import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:grafometria/src/features/analyzer/application/grafometry_analyzer.dart';
import 'package:image/image.dart' as img;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GrafometryAnalyzer input validation', () {
    final analyzer = GrafometryAnalyzer();

    test('rejects a black frame', () async {
      await expectLater(
        analyzer.analyze(_blackFrameBytes()),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Photograph handwritten text and retry.',
          ),
        ),
      );
    });

    test('rejects machine-printed text', () async {
      await expectLater(
        analyzer.analyze(_printedTextBytes()),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Photograph handwritten text and retry.',
          ),
        ),
      );
    });

    test('rejects photographed machine-printed text', () async {
      await expectLater(
        analyzer.analyze(_printedPhotoBytes()),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Photograph handwritten text and retry.',
          ),
        ),
      );
    });

    test('rejects soft photographed machine-printed text', () async {
      await expectLater(
        analyzer.analyze(_printedSoftPhotoBytes()),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Photograph handwritten text and retry.',
          ),
        ),
      );
    });

    test('rejects close-up machine-printed text', () async {
      await expectLater(
        analyzer.analyze(_printedCloseupPhotoBytes()),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            'Photograph handwritten text and retry.',
          ),
        ),
      );
    });

    test('accepts a handwriting-like sample', () async {
      final profile = await analyzer.analyze(_handwrittenSampleBytes());

      expect(profile.confidenceScore, greaterThan(0.2));
      expect(profile.qualityGateScore, greaterThan(0.2));
    });
  });
}

Uint8List _blackFrameBytes() {
  final image = img.Image(width: 900, height: 600);
  img.fill(image, color: img.ColorRgb8(0, 0, 0));
  return Uint8List.fromList(img.encodePng(image));
}

Uint8List _printedTextBytes() {
  final image = _blankCanvas();
  final black = img.ColorRgb8(0, 0, 0);

  img.drawString(
    image,
    'PRINTED TEXT ONLY',
    font: img.arial48,
    x: 50,
    y: 70,
    color: black,
  );
  img.drawString(
    image,
    'THIS SHOULD FAIL',
    font: img.arial48,
    x: 50,
    y: 170,
    color: black,
  );
  img.drawString(
    image,
    'NOT HANDWRITING',
    font: img.arial48,
    x: 50,
    y: 270,
    color: black,
  );

  return Uint8List.fromList(img.encodePng(image));
}

Uint8List _handwrittenSampleBytes() {
  final image = _blankCanvas();
  final black = img.ColorRgb8(0, 0, 0);

  _drawHandwritingLine(image, black, startX: 45, baseY: 150, seed: 0.0);
  _drawHandwritingLine(image, black, startX: 55, baseY: 300, seed: 1.6);

  return Uint8List.fromList(img.encodePng(image));
}

Uint8List _printedPhotoBytes() {
  final image = _blankCanvas();
  final black = img.ColorRgb8(16, 16, 16);
  final paper = img.ColorRgb8(250, 248, 242);
  image.backgroundColor = paper;
  img.fill(image, color: paper);

  img.drawString(
    image,
    'ARIAL PRINTED SAMPLE',
    font: img.arial48,
    x: 60,
    y: 90,
    color: black,
  );
  img.drawString(
    image,
    'THIS IS NOT HANDWRITING',
    font: img.arial48,
    x: 70,
    y: 190,
    color: black,
  );
  img.drawString(
    image,
    'PLEASE REJECT THIS FRAME',
    font: img.arial48,
    x: 55,
    y: 290,
    color: black,
  );

  final rotated = img.copyRotate(
    image,
    angle: -2.4,
    interpolation: img.Interpolation.average,
  );
  rotated.backgroundColor = paper;
  img.gaussianBlur(rotated, radius: 1);
  img.noise(rotated, 6, random: math.Random(42));
  img.adjustColor(rotated, contrast: 1.05, brightness: 1.02);

  return Uint8List.fromList(img.encodeJpg(rotated, quality: 82));
}

Uint8List _printedSoftPhotoBytes() {
  final image = _blankCanvas();
  final black = img.ColorRgb8(28, 28, 28);
  final paper = img.ColorRgb8(244, 242, 236);
  image.backgroundColor = paper;
  img.fill(image, color: paper);

  img.drawString(
    image,
    'ARIAL TEXT',
    font: img.arial48,
    x: 120,
    y: 120,
    color: black,
  );
  img.drawString(
    image,
    'ONLY PRINTED',
    font: img.arial48,
    x: 135,
    y: 225,
    color: black,
  );

  var transformed = img.copyRotate(
    image,
    angle: 1.8,
    interpolation: img.Interpolation.average,
  );
  transformed = img.copyResize(
    transformed,
    width: (transformed.width * 0.58).round(),
  );
  transformed = img.copyResize(
    transformed,
    width: 900,
    height: 500,
    interpolation: img.Interpolation.linear,
  );
  img.gaussianBlur(transformed, radius: 2);
  img.noise(transformed, 4, random: math.Random(7));
  img.adjustColor(transformed, contrast: 1.02, brightness: 1.01);

  return Uint8List.fromList(img.encodeJpg(transformed, quality: 68));
}

Uint8List _printedCloseupPhotoBytes() {
  final image = _blankCanvas();
  final black = img.ColorRgb8(24, 24, 24);
  final paper = img.ColorRgb8(246, 246, 240);
  image.backgroundColor = paper;
  img.fill(image, color: paper);

  img.drawString(
    image,
    'ARIAL',
    font: img.arial48,
    x: 140,
    y: 160,
    color: black,
  );

  var transformed = img.copyResize(image, width: 540, height: 300);
  transformed = img.copyResize(
    transformed,
    width: 900,
    height: 500,
    interpolation: img.Interpolation.linear,
  );
  img.gaussianBlur(transformed, radius: 3);
  img.noise(transformed, 3, random: math.Random(19));
  img.adjustColor(transformed, contrast: 1.04, brightness: 1.00);

  return Uint8List.fromList(img.encodeJpg(transformed, quality: 62));
}

img.Image _blankCanvas() {
  final image = img.Image(width: 900, height: 500);
  img.fill(image, color: img.ColorRgb8(255, 255, 255));
  return image;
}

void _drawHandwritingLine(
  img.Image image,
  img.Color color, {
  required int startX,
  required int baseY,
  required double seed,
}) {
  var cursor = startX;
  for (var word = 0; word < 2; word++) {
    final points = <math.Point<int>>[];
    for (var i = 0; i < 30; i++) {
      final x = cursor + i * 8;
      final y =
          baseY +
          (math.sin(seed + i / 1.9) * 12).round() +
          (i % 11 == 4 ? -18 : 0) +
          (i % 13 == 8 ? 10 : 0);
      points.add(math.Point<int>(x, y));
    }

    _drawThickPolyline(image, points, color, thickness: 4);
    _drawThickPolyline(
      image,
      [
        math.Point<int>(cursor + 42, baseY + 2),
        math.Point<int>(cursor + 54, baseY - 34),
        math.Point<int>(cursor + 68, baseY + 5),
      ],
      color,
      thickness: 3,
    );
    _drawThickPolyline(
      image,
      [
        math.Point<int>(cursor + 130, baseY - 3),
        math.Point<int>(cursor + 146, baseY + 24),
        math.Point<int>(cursor + 164, baseY - 2),
      ],
      color,
      thickness: 3,
    );

    cursor += 300;
  }
}

void _drawThickPolyline(
  img.Image image,
  List<math.Point<int>> points,
  img.Color color, {
  int thickness = 3,
}) {
  for (var index = 0; index < points.length - 1; index++) {
    final from = points[index];
    final to = points[index + 1];
    for (var offset = -thickness; offset <= thickness; offset++) {
      img.drawLine(
        image,
        x1: from.x,
        y1: from.y + offset,
        x2: to.x,
        y2: to.y + offset,
        color: color,
      );
    }
  }
}
