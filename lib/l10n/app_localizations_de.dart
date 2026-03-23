// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'HandwritingAnalysis';

  @override
  String get languageTooltip => 'Sprache';

  @override
  String get languageSystemDefault => 'Systemstandard';

  @override
  String get privacyTooltip => 'Datenschutz und Haftungsausschluss';

  @override
  String get loadingPrivacySettings => 'Datenschutzeinstellungen werden geladen...';

  @override
  String get tickConsentBeforeContinuing => 'Bitte Zustimmung markieren, bevor Sie fortfahren.';

  @override
  String get consentSavedCameraEnabled => 'Zustimmung gespeichert. Kameraufnahme aktiviert.';

  @override
  String get analyzingPreparingResultPopup => 'Handschrift wird analysiert und Ergebnis-Popup vorbereitet...';

  @override
  String freeModeSummary(Object price) {
    return 'Free-Modus: Basisprofil mit Werbung. Pro-Modus: Vollbericht fur $price.';
  }

  @override
  String get headerSubtitle => 'Live-Kamera-Analyse. Modernes Ergebnis-Popup mit klaren Ampel-Indikatoren.';

  @override
  String get captureLivePhoto => 'Live-Foto aufnehmen';

  @override
  String get trustLiveCameraOnly => 'Nur Live-Kamera';

  @override
  String get trustNoGalleryOrFile => 'Keine Galerie-/Datei-Eingabe';

  @override
  String get trustTemporaryCleanup => 'Temporare Foto-Bereinigung';

  @override
  String get consentRequiredTitle => 'Zustimmung zu Datenschutz und Haftungsausschluss erforderlich';

  @override
  String get consentRequiredBody => 'Bitte Datenschutz/Haftungsausschluss vor der ersten Analyse lesen. Die App ist edukativ und nicht diagnostisch.';

  @override
  String get consentCheckbox => 'Ich habe die Richtlinie gelesen und stimme zu.';

  @override
  String get readPolicy => 'Richtlinie lesen';

  @override
  String get acceptAndContinue => 'Akzeptieren und fortfahren';

  @override
  String get noCaptureYet => 'Noch keine Aufnahme. Bitte Live-Kamera verwenden.';

  @override
  String get resultPopupReadyTitle => 'Ihr Ergebnis-Popup ist bereit';

  @override
  String get proPopupReadyTitle => 'Ihr Pro-Popup-Bericht ist bereit';

  @override
  String get resultPopupBody => 'Offnen Sie das Popup mit Tabs fur Free, Pro und Teilen.';

  @override
  String get openResultPopup => 'Ergebnis offnen';

  @override
  String get share => 'Teilen';

  @override
  String get purchaseStreamError => 'Fehler im Kauf-Stream.';

  @override
  String storeProductUnavailable(Object productId) {
    return 'Store-Produkt nicht verfugbar. Konfigurieren Sie zuerst \"$productId\".';
  }

  @override
  String get openingSecureCheckout => 'Sicherer Checkout wird geoffnet...';

  @override
  String get proReportUnlocked => 'Pro-Bericht freigeschaltet.';

  @override
  String get purchaseFailed => 'Kauf fehlgeschlagen.';

  @override
  String get purchaseCanceled => 'Kauf abgebrochen.';

  @override
  String get privacyAccepted => 'Datenschutz und Haftungsausschluss akzeptiert.';

  @override
  String get consentWithdrawn => 'Zustimmung widerrufen. Aufnahme deaktiviert.';

  @override
  String get shareMyResult => 'Mein HandwritingAnalysis Ergebnis:';

  @override
  String shareConfidenceLine(Object label, Object percent) {
    return 'Vertrauen: $label ($percent%)';
  }

  @override
  String get shareDetailedMetricsHeader => 'Detaillierte Metriken:';

  @override
  String get shareProHint => 'Pro-Freischaltung zeigt alle quantitativen Details.';

  @override
  String get shareTryApp => 'Probieren Sie HandwritingAnalysis aus.';

  @override
  String get graphometryResult => 'HandwritingAnalysis Ergebnis';

  @override
  String reliabilityLine(Object label, Object percent) {
    return 'Zuverlassigkeit: $label ($percent%)';
  }

  @override
  String get confidenceHigh => 'Hoch';

  @override
  String get confidenceMedium => 'Mittel';

  @override
  String get confidenceLow => 'Niedrig';

  @override
  String photoQualityShortLine(Object percent) {
    return 'Fotoqualitat: $percent%';
  }

  @override
  String get overallSummaryGreen => 'Regelmassige Probe: ausgewogenes grafisches Muster ohne starke Belastungsmarker.';

  @override
  String get overallSummaryOrange => 'Variable Probe: Stresssensibilitat und Spannung vorsichtig einordnen.';

  @override
  String get overallSummaryRed => 'Starker belastete oder diskontinuierliche Probe: mogliche Fatigue- und Spannungsmarker.';

  @override
  String get overallDescriptionGreen => 'Grunes Profil: Diese Probe liegt im regulareren Bereich, mit gleichmassigerem Rhythmus, begrenzter Aktivierung und insgesamt geordneterer visueller Ausfuhrung.';

  @override
  String get overallDescriptionOrange => 'Oranges Profil: Diese Probe zeigt mehr Variabilitat, mogliche Sensibilitat gegen situativen Druck und Rhythmusschwankungen, die mit anderen Beobachtungen kontextualisiert werden sollten.';

  @override
  String get overallDescriptionRed => 'Rotes Profil: Diese Probe zeigt hohere grafische Last oder deutliche Diskontinuitat. Solche Marker konnen mit Spannung, Ermudung oder instabiler Ausfuhrung zusammengehen, sind aber keine Diagnose.';

  @override
  String quickSummaryCompact(Object state, Object baseline, Object slant) {
    return '$state Baseline-Tendenz: $baseline. Beziehungsstil: $slant.';
  }

  @override
  String get quickBaselineUp => 'aufwarts';

  @override
  String get quickBaselineDown => 'abwarts';

  @override
  String get quickBaselineStable => 'stabil';

  @override
  String get quickSlantRight => 'offener';

  @override
  String get quickSlantLeft => 'reservierter';

  @override
  String get quickSlantNeutral => 'ausgewogen';

  @override
  String detailedSpacingNarrative(Object value, Object tendency) {
    return 'Das Abstandsverhaltnis $value deutet auf $tendency hin.';
  }

  @override
  String get detailedSpacingAutonomy => 'eine starkere Autonomie-Tendenz';

  @override
  String get detailedSpacingCloseness => 'eine starkere relationale Nahe-Tendenz';

  @override
  String detailedSizeNarrative(Object value, Object tendency) {
    return 'Die Grossenvarianz $value deutet auf $tendency hin.';
  }

  @override
  String get detailedSizeFluctuating => 'schwankende Aufmerksamkeitskonsistenz';

  @override
  String get detailedSizeStable => 'einen stabilen Aufmerksamkeitsrhythmus';

  @override
  String detailedPenLiftNarrative(Object value, Object tendency) {
    return 'Die Stiftabsetz-Frequenz $value deutet auf $tendency hin.';
  }

  @override
  String get detailedPenLiftSegmented => 'segmentierte kognitive Sequenzierung';

  @override
  String get detailedPenLiftFluid => 'flussige kognitive Kontinuitat';

  @override
  String psychologicalSnapshot(Object baseline, Object slant, Object pressure, Object spacing, Object rhythm) {
    return 'Vorsichtige psychologische Lesart: Baseline $baseline, Neigung $slant, Druck deutet auf $pressure, Abstand passt zu $spacing, und der Schreibrhythmus wirkt naher an $rhythm.';
  }

  @override
  String get psychPressureHigh => 'hoherer innerer Aktivierung';

  @override
  String get psychPressureBalanced => 'relativ ausgewogener tonischer Modulation';

  @override
  String get psychPressureLow => 'begrenzter Aktivierung oder leichterem Strich';

  @override
  String get confidenceAdviceHigh => 'Die Zuverlassigkeit ist fur eine explorative Lesart gut, aber das Bild bleibt nur ein visueller Hinweis.';

  @override
  String get confidenceAdviceMedium => 'Die Zuverlassigkeit ist mittel: Nutzen Sie das Ergebnis als Anstoss, nicht als Schlussfolgerung.';

  @override
  String get confidenceAdviceLow => 'Die Zuverlassigkeit ist niedrig: Foto wiederholen und mehrere Proben vergleichen, bevor Sie es interpretieren.';

  @override
  String get wellbeingSuggestionTitle => 'Wellbeing-Hinweis';

  @override
  String get wellbeingSuggestionGreen => 'Wenn die Probe stimmig wirkt, schutzen Sie dieses Gleichgewicht mit einfachen Routinen: regelmassiger Schlaf, kurze Pausen und langsameres Schreiben ohne Eile.';

  @override
  String get wellbeingSuggestionOrange => 'Wenn Spannung wiederkehrt, helfen oft kurze Pausen, langsameres Atmen, weniger Eile und ein paar Zeilen Journaling zum Entlasten.';

  @override
  String get wellbeingSuggestionRed => 'Wenn sich diese Zeichen uber mehrere Proben oder zusammen mit echtem Leiden wiederholen, reduzieren Sie Uberlastung, schutzen Sie Schlaf und Pausen und ziehen Sie qualifizierte Hilfe in Betracht.';

  @override
  String get detailedInterpretationNote => 'Interpretationshinweis: Graphomotorische Marker konnen die Qualitat der Schreibbewegung beschreiben, aber Personlichkeits-Graphologie hat keine robuste Validierung; diese Lesart bleibt explorativ und nicht diagnostisch.';

  @override
  String get psychCuesTitle => 'Explorative psychologische Hinweise';

  @override
  String get psychCuesBody => 'Dies sind orientierende Etiketten aus Druck, Regelmassigkeit und Rhythmus der Schreibbewegung. Sie machen das Profil psychologischer, definieren die Person aber nicht eindeutig.';

  @override
  String get psychCueSerenity => 'Gelassenheit';

  @override
  String get psychCueSerenityDetail => 'Die Schreibbewegung wirkt gut reguliert, mit begrenzter Last und recht geordneter Kontinuitat.';

  @override
  String get psychCueActivation => 'Aktivierung';

  @override
  String get psychCueActivationDetail => 'Es ist Energie vorhanden, aber nicht extrem; die Probe sollte im Kontext des Moments gelesen werden.';

  @override
  String get psychCueStress => 'Stress';

  @override
  String get psychCueStressDetail => 'Hoherer Druck oder starkere Fragmentierung konnen mit situativer Spannung und Uberlastung einhergehen.';

  @override
  String get psychCueStability => 'Stabilitat';

  @override
  String get psychCueStabilityDetail => 'Linie und Proportionen bleiben recht koharent und sprechen fur eine stabilere Schreibbewegung.';

  @override
  String get psychCueSensitivity => 'Sensibilitat';

  @override
  String get psychCueSensitivityDetail => 'Kleinere Schwankungen der Schreibbewegung konnen Kontextreaktivitat oder momentane Variabilitat spiegeln.';

  @override
  String get psychCueDiscontinuity => 'Diskontinuitat';

  @override
  String get psychCueDiscontinuityDetail => 'Deutlichere Ausschlage der Schreibbewegung konnen auf ein weniger regelmassiges Muster hindeuten.';

  @override
  String get psychCueFluidity => 'Flussigkeit';

  @override
  String get psychCueFluidityDetail => 'Die Schreibsequenz wirkt recht kontinuierlich und nur wenig unterbrochen.';

  @override
  String get psychCueVariability => 'Variabilitat';

  @override
  String get psychCueVariabilityDetail => 'Der Rhythmus wechselt zwischen kontinuierlicheren und starker kontrollierten oder segmentierten Passagen.';

  @override
  String get psychCueFragmentation => 'Fragmentierung';

  @override
  String get psychCueFragmentationDetail => 'Der Rhythmus wirkt starker unterbrochen oder gebrochen, mit geringerer motorischer Kontinuitat.';

  @override
  String get metricBaselineName => 'Baseline-Winkel';

  @override
  String get metricBaselineExplanation => 'Misst Linien-Stabilitat und Richtungsdrift in der Schriftprobe.';

  @override
  String get metricBaselineRule => 'Signalregel: Grun <= 4.0°, Orange <= 8.1°, Rot > 8.1°.';

  @override
  String get metricSlantName => 'Neigungswinkel';

  @override
  String get metricSlantExplanation => 'Erfasst emotionale Offenheit versus eher defensiven Kommunikationsstil.';

  @override
  String get metricSlantRule => 'Signalregel: Grun <= 11.3°, Orange <= 18.0°, Rot > 18.0°.';

  @override
  String get metricPressureName => 'Druckindex';

  @override
  String get metricPressureExplanation => 'Schatzt Ausdruckskraft aus Strichdichte und Dunkelheit.';

  @override
  String get metricPressureRule => 'Signalregel: Grun 0.38-0.68, Orange 0.28-0.78, Rot ausserhalb Bereich.';

  @override
  String get metricSpacingName => 'Abstandsverhaltnis';

  @override
  String get metricSpacingExplanation => 'Misst die mittlere Balance der Abstande zwischen Strichgruppen.';

  @override
  String get metricSpacingRule => 'Signalregel: Grun 0.89-1.48, Orange 0.66-1.82, Rot ausserhalb Bereich.';

  @override
  String get metricSizeVarianceName => 'Grossenvarianz';

  @override
  String get metricSizeVarianceExplanation => 'Spiegelt die Konsistenz von Buchstabenhohe und visuellem Rhythmus wider.';

  @override
  String get metricSizeVarianceRule => 'Signalregel: Grun <= 0.38, Orange <= 0.59, Rot > 0.59.';

  @override
  String get metricPenLiftsName => 'Stiftabsetzungen';

  @override
  String get metricPenLiftsExplanation => 'Nahert an, wie segmentiert oder kontinuierlich die motorische Sequenz wirkt.';

  @override
  String get metricPenLiftsRule => 'Signalregel: Grun <= 0.41, Orange <= 0.63, Rot > 0.63.';

  @override
  String get qualityGateTitle => 'Aufnahme-Qualitatscheck';

  @override
  String get qualityGateBody => 'Einige Aufnahmebedingungen reduzieren die Zuverlassigkeit. Verbessern Sie das Foto vor der Interpretation.';

  @override
  String qualityGateScoreLine(Object percent) {
    return 'Aufnahmequalitat: $percent%';
  }

  @override
  String get qualityHintCoverageLow => 'Der Schreibbereich ist im Bildausschnitt zu klein.';

  @override
  String get qualityHintContrastLow => 'Kontrast zu niedrig: mehr Licht und weniger Schatten.';

  @override
  String get qualityHintSharpnessLow => 'Bild wirkt unscharf: Kamera stabilisieren und neu fokussieren.';

  @override
  String get qualityHintGeneric => 'Ein oder mehrere Qualitatsfaktoren liegen unter dem optimalen Niveau.';

  @override
  String get qualityRetakeHint => 'Tipp: naher aufnehmen, gleichmassiges Licht, keine Spiegelungen.';

  @override
  String get scienceRefsTitle => 'Wissenschaftliche Quellen';

  @override
  String get scienceRefsDisclaimer => 'Primarquellen zu drei Bereichen: Grenzen der Personlichkeits-Graphologie, graphomotorische Marker in motorisch-kognitiven Kontexten und mogliche kleine Vorteile des expressiven Schreibens. Sie validieren weder Diagnose noch individuelles psychologisches Profil aus einer einzelnen Probe.';

  @override
  String get openSource => 'Quelle offnen';

  @override
  String get freeProTeaserTitle => 'Mochten Sie die vollstandige Detailanalyse?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Schalten Sie Pro frei fur eine ausfuhrlichere explorative Lesart, alle quantitativen Marker und ein werbefreies Ergebnis fur $price.';
  }

  @override
  String get freeProTeaserButton => 'Pro-Angebot ansehen';

  @override
  String proMoreIndicatorsHint(Object count) {
    return 'Pro-Funktionen: schalten Sie $count zusatzliche Indikatoren und die vollstandige Detailanalyse frei.';
  }

  @override
  String get errorUnsupportedImageFormat => 'Nicht unterstutztes Bildformat.';

  @override
  String get errorImageTooSmall => 'Bild zu klein. Bitte naher und scharfer fotografieren.';

  @override
  String get errorNotEnoughHandwriting => 'Zu wenig Handschrift erkannt. Bitte mit besserem Bildausschnitt erneut versuchen.';

  @override
  String get errorHandwritingRequired => 'Fotografieren Sie einen handgeschriebenen Text. Versuchen Sie es erneut.';

  @override
  String get tabFree => 'Kostenlos';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Teilen';

  @override
  String get legendTitle => 'Psychologische Ampel-Legende';

  @override
  String get legendBody => 'Grun: regulareres und weniger belastetes Muster.\nOrange: Variabilitat und Spannung im Kontext lesen.\nRot: grossere Diskontinuitat oder grafische Last; keine Diagnose.';

  @override
  String get unlockFullPsychProfile => 'Detaillierte Lesart freischalten';

  @override
  String get unlockFullPsychProfileBody => 'Die Analyse ist abgeschlossen. Schalten Sie eine ausfuhrlichere explorative Lesart, die Ampel-Bedeutung und alle quantitativen Marker frei.';

  @override
  String get valuePsychReport => 'Detaillierter explorativer Bericht';

  @override
  String get valueRiskMarkers => 'Potenzielle Risikomarker';

  @override
  String get valueNoAdsThisResult => 'Keine Werbung fur dieses Ergebnis';

  @override
  String get processing => 'Verarbeitung...';

  @override
  String unlockProForPrice(Object price) {
    return 'Pro freischalten fur $price';
  }

  @override
  String get storeSetupPending => 'Einrichtung des Store-Produkts ausstehend.';

  @override
  String get sharePanelText => 'Teilen auf WhatsApp, Telegram, TikTok, Instagram, Facebook oder per System-Share.';

  @override
  String get openPrivacyDisclaimer => 'Datenschutz und Haftungsausschluss offnen';

  @override
  String get policyTitle => 'Datenschutz und Haftungsausschluss';

  @override
  String get policyBody => 'Aktualisiert: 4. Marz 2026\n\n1) Zweck und Rechtsgrundlage\nNur edukative Nutzung. Die Verarbeitung basiert auf ausdrucklicher Einwilligung (DSGVO Art. 6(1)(a) und ggf. Art. 9(2)(a)).\n\n2) Datenminimierung\nNur Live-Kamera. Keine Galerie-/Datei-Eingabe. Temporare Fotos werden nach bestem Bemuhen geloscht. Die Grundsatze der Datenminimierung und Zweckbindung werden angewendet (DSGVO Art. 5 und Art. 25).\n\n3) Grenzen des Profilings\nDiese App nicht fur Entscheidungen zu Einstellung, Kredit, Versicherung, Recht oder anderen hochwirksamen Bereichen nutzen. Entscheidungen durfen nicht ausschliesslich auf dieser automatisierten Ausgabe beruhen (DSGVO Art. 22).\n\n4) Verarbeitung durch Dritte\nDer Free-Modus nutzt Werbe-SDKs. Die Pro-Freischaltung nutzt Store-Abrechnung. Anbieter konnen Geraete-/Transaktionskennungen verarbeiten.\n\n5) Transparenz\nNutzer werden daruber informiert, dass sie mit KI-generierten Inhalten interagieren (AI Act Art. 50, Transparenzprinzip).\n\n6) Grenzen verbotener Nutzung\nDie App darf nicht fur manipulative oder schadliche Social-Scoring-ahnliche Zwecke verwendet werden (AI Act Art. 5, verbotene Praktiken).\n\n7) Rechte der Nutzer\nNutzer konnen ihre Einwilligung jederzeit in diesem Bereich widerrufen. Informationspflichten und Rechte sollten im storeseitigen Datenschutzhinweis abgebildet sein (DSGVO Art. 13 und Art. 15-17).\n\n8) Medizinischer Hinweis\nEs wird keine medizinische oder klinische Diagnose gestellt. Ein rotes Ergebnis zeigt potenzielle Risikomarker, keine bestatigte Storung.\n\n9) Compliance-Hinweis\nDieser In-App-Text ist keine Rechtsberatung. Vor Veroffentlichung ist eine vollstandige Rechtsprufung erforderlich.';

  @override
  String get withdrawConsent => 'Zustimmung widerrufen';

  @override
  String get keepDisabled => 'Deaktiviert lassen';

  @override
  String get accept => 'Akzeptieren';

  @override
  String get signalBalance => 'Gleichgewicht';

  @override
  String get signalVulnerability => 'Vulnerabilitat';

  @override
  String get signalPotentialPathology => 'Hohere Last';

  @override
  String get overallGreenTitle => 'GRUNES PROFIL - Regelmassigere Probe';

  @override
  String get overallOrangeTitle => 'ORANGES PROFIL - Variabilitat und Spannung';

  @override
  String get overallRedTitle => 'ROTES PROFIL - Last oder Diskontinuitat';

  @override
  String get proUnlockedFullDataAvailable => 'Pro freigeschaltet. Vollstandige Daten verfugbar.';

  @override
  String get storeProductUnavailableNow => 'Store-Produkt nicht verfugbar.';

  @override
  String get whatsappLabel => 'WhatsApp';

  @override
  String get telegramLabel => 'Telegram';

  @override
  String get tiktokLabel => 'TikTok';

  @override
  String get instagramLabel => 'Instagram';

  @override
  String get facebookLabel => 'Facebook';

  @override
  String get moreLabel => 'Mehr';
}
