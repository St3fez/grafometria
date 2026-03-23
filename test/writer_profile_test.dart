import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grafometria/l10n/app_localizations.dart';
import 'package:grafometria/src/features/analyzer/domain/writer_profile.dart';

void main() {
  group('WriterProfile exploratory cues', () {
    testWidgets('maps a regulated sample to serenity stability and fluidity', (
      tester,
    ) async {
      final l10n = await _resolveL10n(tester, const Locale('it'));
      final cues = _greenProfile().exploratoryCues(l10n);

      expect(cues.map((cue) => cue.title).toList(), [
        'Serenità',
        'Stabilità',
        'Fluidità',
      ]);
    });

    testWidgets(
      'maps a mixed sample to activation sensitivity and variability',
      (tester) async {
        final l10n = await _resolveL10n(tester, const Locale('it'));
        final cues = _orangeProfile().exploratoryCues(l10n);

        expect(cues.map((cue) => cue.title).toList(), [
          'Attivazione',
          'Sensibilità',
          'Variabilità',
        ]);
      },
    );

    testWidgets('maps a loaded sample to stress and keeps higher-load cues', (
      tester,
    ) async {
      final l10n = await _resolveL10n(tester, const Locale('it'));
      final cues = _redProfile().exploratoryCues(l10n);

      expect(cues.first.title, 'Stress');
      expect(cues.any((cue) => cue.signal == MetricSignal.red), isTrue);
      expect(cues.length, 3);
    });
  });
}

Future<AppLocalizations> _resolveL10n(
  WidgetTester tester,
  Locale locale,
) async {
  AppLocalizations? l10n;
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          l10n = AppLocalizations.of(context);
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 100));
  return l10n!;
}

WriterProfile _greenProfile() {
  return const WriterProfile(
    baselineAngle: 0.0,
    slantAngle: 0.0,
    pressureIndex: 0.5,
    spacingRatio: 1.1,
    letterSizeVariance: 0.2,
    penLiftFrequency: 0.2,
    confidenceScore: 0.92,
  );
}

WriterProfile _orangeProfile() {
  return const WriterProfile(
    baselineAngle: 8.0,
    slantAngle: 12.0,
    pressureIndex: 0.72,
    spacingRatio: 1.1,
    letterSizeVariance: 0.2,
    penLiftFrequency: 0.2,
    confidenceScore: 0.92,
  );
}

WriterProfile _redProfile() {
  return const WriterProfile(
    baselineAngle: 9.2,
    slantAngle: 20.0,
    pressureIndex: 0.82,
    spacingRatio: 1.1,
    letterSizeVariance: 0.64,
    penLiftFrequency: 0.68,
    confidenceScore: 0.92,
  );
}
