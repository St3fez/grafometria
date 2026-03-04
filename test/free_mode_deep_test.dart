import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grafometria/l10n/app_localizations.dart';
import 'package:grafometria/src/features/analyzer/domain/writer_profile.dart';
import 'package:grafometria/src/features/analyzer/presentation/analyzer_page.dart';

void main() {
  group('Free mode deep checks', () {
    testWidgets('renders Italian free shell without English leftovers', (
      tester,
    ) async {
      await tester.pumpWidget(
        _localizedHost(
          locale: const Locale('it'),
          child: const AnalyzerPage(
            enableMonetization: false,
            onLocaleChanged: _noopLocaleChange,
            localeOverrideCode: 'it',
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Scatta Foto Live'), findsOneWidget);
      expect(find.text('Solo fotocamera live'), findsOneWidget);
      expect(
        find.text(
          'Modalità Free: profilo base con pubblicità. Modalità Pro: report completo a €0.99.',
        ),
        findsOneWidget,
      );
      expect(find.textContaining('Free mode:'), findsNothing);
    });

    testWidgets('stays stable on compact screens in free mode', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1.0;
      tester.view.physicalSize = const Size(320, 640);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        _localizedHost(
          locale: const Locale('it'),
          child: const AnalyzerPage(
            enableMonetization: false,
            onLocaleChanged: _noopLocaleChange,
            localeOverrideCode: 'it',
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Scatta Foto Live'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('localizes free profile outputs and metric names in Italian', (
      tester,
    ) async {
      final l10n = await _resolveL10n(tester, const Locale('it'));
      final profile = _orangeProfile();
      final quick = profile.quickSummary(l10n);
      final metrics = profile.detailedMetrics(l10n);

      expect(quick, contains('Andamento baseline'));
      expect(quick, isNot(contains('Overall pattern')));
      expect(metrics.first.name, 'Angolo baseline');
      expect(metrics.any((m) => m.name == 'Baseline angle'), isFalse);
      expect(metrics.length, 6);
      expect(l10n.proMoreIndicatorsHint(metrics.length - 3), contains('3'));
    });

    testWidgets('keeps overall free summaries concise per signal', (tester) async {
      final l10n = await _resolveL10n(tester, const Locale('it'));
      final summaries = [
        _greenProfile().overallStateSummary(l10n),
        _orangeProfile().overallStateSummary(l10n),
        _redProfile().overallStateSummary(l10n),
      ];

      for (final summary in summaries) {
        expect(summary.length, lessThanOrEqualTo(75));
      }
    });
  });
}

Widget _localizedHost({required Locale locale, required Widget child}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

Future<AppLocalizations> _resolveL10n(WidgetTester tester, Locale locale) async {
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

void _noopLocaleChange(String? _) {}

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
    pressureIndex: 0.5,
    spacingRatio: 1.1,
    letterSizeVariance: 0.2,
    penLiftFrequency: 0.2,
    confidenceScore: 0.92,
  );
}

WriterProfile _redProfile() {
  return const WriterProfile(
    baselineAngle: 8.0,
    slantAngle: 20.0,
    pressureIndex: 0.8,
    spacingRatio: 1.1,
    letterSizeVariance: 0.2,
    penLiftFrequency: 0.2,
    confidenceScore: 0.92,
  );
}
