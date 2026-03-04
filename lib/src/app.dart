import 'package:flutter/material.dart';
import 'package:grafometria/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/analyzer/presentation/analyzer_page.dart';

class GrafometriaApp extends StatefulWidget {
  const GrafometriaApp({super.key, this.enableMonetization = true});

  final bool enableMonetization;

  @override
  State<GrafometriaApp> createState() => _GrafometriaAppState();
}

class _GrafometriaAppState extends State<GrafometriaApp> {
  static const _localePreferenceKey = 'graphometry_locale_v1';
  static const _supportedLanguageCodes = {'de', 'en', 'es', 'fr', 'it'};

  Locale? _localeOverride;

  bool get _isWidgetTest => const bool.fromEnvironment('FLUTTER_TEST');

  @override
  void initState() {
    super.initState();
    if (_isWidgetTest) {
      return;
    }
    _loadLocalePreference();
  }

  Future<void> _loadLocalePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_localePreferenceKey);
      if (!mounted || code == null || !_supportedLanguageCodes.contains(code)) {
        return;
      }
      setState(() {
        _localeOverride = Locale(code);
      });
    } catch (_) {}
  }

  Future<void> _setLocale(String? languageCode) async {
    final normalizedCode =
        languageCode != null && _supportedLanguageCodes.contains(languageCode)
            ? languageCode
            : null;
    setState(() {
      _localeOverride =
          normalizedCode == null ? null : Locale(normalizedCode);
    });
    if (_isWidgetTest) {
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      if (normalizedCode == null) {
        await prefs.remove(_localePreferenceKey);
      } else {
        await prefs.setString(_localePreferenceKey, normalizedCode);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0F766E);
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF2F7F8),
      useMaterial3: true,
    );

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      locale: _localeOverride,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.manropeTextTheme(baseTheme.textTheme),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: AnalyzerPage(
        enableMonetization: widget.enableMonetization,
        onLocaleChanged: _setLocale,
        localeOverrideCode: _localeOverride?.languageCode,
      ),
    );
  }
}
