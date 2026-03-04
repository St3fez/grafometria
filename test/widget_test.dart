import 'package:flutter_test/flutter_test.dart';

import 'package:grafometria/src/app.dart';

void main() {
  testWidgets('renders analyzer shell', (WidgetTester tester) async {
    await tester.pumpWidget(const GrafometriaApp(enableMonetization: false));

    expect(find.text('HandwritingAnalysis'), findsWidgets);
    expect(find.text('Capture Live Photo'), findsOneWidget);
    expect(find.text('Live camera only'), findsOneWidget);
  });
}
