// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'HandwritingAnalysis';

  @override
  String get languageTooltip => 'Lingua';

  @override
  String get languageSystemDefault => 'Predefinita di sistema';

  @override
  String get privacyTooltip => 'Privacy e disclaimer';

  @override
  String get loadingPrivacySettings => 'Caricamento impostazioni privacy...';

  @override
  String get tickConsentBeforeContinuing => 'Seleziona il consenso prima di continuare.';

  @override
  String get consentSavedCameraEnabled => 'Consenso salvato. Acquisizione fotocamera abilitata.';

  @override
  String get analyzingPreparingResultPopup => 'Analisi della scrittura e preparazione del popup risultato...';

  @override
  String freeModeSummary(Object price) {
    return 'Modalità Free: profilo base con pubblicità. Modalità Pro: report completo a $price.';
  }

  @override
  String get headerSubtitle => 'Analisi con fotocamera live. Risultato moderno in popup con indicatori semaforici chiari.';

  @override
  String get captureLivePhoto => 'Scatta Foto Live';

  @override
  String get trustLiveCameraOnly => 'Solo fotocamera live';

  @override
  String get trustNoGalleryOrFile => 'Nessuna galleria o file';

  @override
  String get trustTemporaryCleanup => 'Pulizia foto temporanee';

  @override
  String get consentRequiredTitle => 'Consenso privacy e disclaimer richiesto';

  @override
  String get consentRequiredBody => 'Leggi privacy/disclaimer prima della prima analisi. L\'app è divulgativa e non diagnostica.';

  @override
  String get consentCheckbox => 'Ho letto e accetto la policy.';

  @override
  String get readPolicy => 'Leggi policy';

  @override
  String get acceptAndContinue => 'Accetta e continua';

  @override
  String get noCaptureYet => 'Nessuna acquisizione. Usa la fotocamera live.';

  @override
  String get resultPopupReadyTitle => 'Il tuo popup risultato è pronto';

  @override
  String get proPopupReadyTitle => 'Il tuo report Pro in popup è pronto';

  @override
  String get resultPopupBody => 'Apri il popup a schede Free, Pro e Share.';

  @override
  String get openResultPopup => 'Apri Popup Risultato';

  @override
  String get share => 'Condividi';

  @override
  String get purchaseStreamError => 'Errore nello stream acquisti.';

  @override
  String storeProductUnavailable(Object productId) {
    return 'Prodotto store non disponibile. Configura prima \"$productId\".';
  }

  @override
  String get openingSecureCheckout => 'Apertura checkout sicuro...';

  @override
  String get proReportUnlocked => 'Report Pro sbloccato.';

  @override
  String get purchaseFailed => 'Acquisto non riuscito.';

  @override
  String get purchaseCanceled => 'Acquisto annullato.';

  @override
  String get privacyAccepted => 'Privacy e disclaimer accettati.';

  @override
  String get consentWithdrawn => 'Consenso revocato. Acquisizione disabilitata.';

  @override
  String get shareMyResult => 'Il mio risultato HandwritingAnalysis:';

  @override
  String shareConfidenceLine(Object label, Object percent) {
    return 'Affidabilità: $label ($percent%)';
  }

  @override
  String get shareDetailedMetricsHeader => 'Metriche dettagliate:';

  @override
  String get shareProHint => 'Lo sblocco Pro mostra tutti i dettagli quantitativi.';

  @override
  String get shareTryApp => 'Prova HandwritingAnalysis.';

  @override
  String get graphometryResult => 'Risultato HandwritingAnalysis';

  @override
  String reliabilityLine(Object label, Object percent) {
    return 'Affidabilità: $label ($percent%)';
  }

  @override
  String get confidenceHigh => 'Alta';

  @override
  String get confidenceMedium => 'Media';

  @override
  String get confidenceLow => 'Bassa';

  @override
  String photoQualityShortLine(Object percent) {
    return 'Qualità foto: $percent%';
  }

  @override
  String get overallSummaryGreen => 'Profilo generale: personalità centrata, serena e con buona autoregolazione.';

  @override
  String get overallSummaryOrange => 'Profilo generale: personalità sensibile con tensione interna e sbalzi.';

  @override
  String get overallSummaryRed => 'Profilo generale: segnali di disregolazione emotiva e rischio elevato.';

  @override
  String get overallDescriptionGreen => 'Profilo verde: emergono stabilità affettiva, buon controllo degli impulsi e capacità di adattarsi allo stress quotidiano senza perdere equilibrio.';

  @override
  String get overallDescriptionOrange => 'Profilo arancione: emergono elevata sensibilità, carico interno aumentato e vulnerabilità alla pressione; nelle fasi stressanti può crescere la reattività relazionale.';

  @override
  String get overallDescriptionRed => 'Profilo rosso: emergono pattern persistenti di sofferenza psicologica, possibile disregolazione affettiva e marcatori potenzialmente patologici. Se il quadro si ripete, è consigliabile un approfondimento professionale.';

  @override
  String quickSummaryCompact(Object state, Object baseline, Object slant) {
    return '$state Andamento baseline: $baseline. Stile relazionale: $slant.';
  }

  @override
  String get quickBaselineUp => 'in crescita';

  @override
  String get quickBaselineDown => 'in calo';

  @override
  String get quickBaselineStable => 'stabile';

  @override
  String get quickSlantRight => 'più aperto';

  @override
  String get quickSlantLeft => 'più riservato';

  @override
  String get quickSlantNeutral => 'equilibrato';

  @override
  String detailedSpacingNarrative(Object value, Object tendency) {
    return 'Il rapporto di spaziatura $value suggerisce $tendency.';
  }

  @override
  String get detailedSpacingAutonomy => 'una maggiore tendenza all\'autonomia';

  @override
  String get detailedSpacingCloseness => 'una maggiore tendenza alla vicinanza relazionale';

  @override
  String detailedSizeNarrative(Object value, Object tendency) {
    return 'La varianza dimensionale $value suggerisce $tendency.';
  }

  @override
  String get detailedSizeFluctuating => 'una continuità attentiva fluttuante';

  @override
  String get detailedSizeStable => 'un ritmo attentivo stabile';

  @override
  String detailedPenLiftNarrative(Object value, Object tendency) {
    return 'La frequenza dei sollevamenti penna $value suggerisce $tendency.';
  }

  @override
  String get detailedPenLiftSegmented => 'una sequenza cognitiva più segmentata';

  @override
  String get detailedPenLiftFluid => 'una continuità cognitiva più fluida';

  @override
  String get detailedInterpretationNote => 'Nota interpretativa: questa lettura è di tipo screening psicologico e non costituisce diagnosi medica o psichiatrica.';

  @override
  String get metricBaselineName => 'Angolo baseline';

  @override
  String get metricBaselineExplanation => 'Traccia stabilità della linea e deriva direzionale nel campione di scrittura.';

  @override
  String get metricBaselineRule => 'Regola segnale: Verde <= 4.5°, Arancione <= 9°, Rosso > 9°.';

  @override
  String get metricSlantName => 'Angolo inclinazione';

  @override
  String get metricSlantExplanation => 'Rileva apertura emotiva rispetto a uno stile comunicativo più difensivo.';

  @override
  String get metricSlantRule => 'Regola segnale: Verde <= 12.5°, Arancione <= 20°, Rosso > 20°.';

  @override
  String get metricPressureName => 'Indice pressione';

  @override
  String get metricPressureExplanation => 'Stima la forza espressiva da densità e scurezza del tratto.';

  @override
  String get metricPressureRule => 'Regola segnale: Verde 0.34-0.72, Arancione 0.24-0.82, Rosso fuori range.';

  @override
  String get metricSpacingName => 'Rapporto spaziatura';

  @override
  String get metricSpacingExplanation => 'Misura l\'equilibrio medio degli spazi tra i gruppi di tratto.';

  @override
  String get metricSpacingRule => 'Regola segnale: Verde 0.82-1.55, Arancione 0.60-1.95, Rosso fuori range.';

  @override
  String get metricSizeVarianceName => 'Varianza dimensione';

  @override
  String get metricSizeVarianceExplanation => 'Riflette la coerenza di altezza delle lettere e del ritmo visivo.';

  @override
  String get metricSizeVarianceRule => 'Regola segnale: Verde <= 0.42, Arancione <= 0.66, Rosso > 0.66.';

  @override
  String get metricPenLiftsName => 'Sollevamenti penna';

  @override
  String get metricPenLiftsExplanation => 'Approssima quanto la sequenza motoria appaia segmentata o continua.';

  @override
  String get metricPenLiftsRule => 'Regola segnale: Verde <= 0.46, Arancione <= 0.70, Rosso > 0.70.';

  @override
  String get qualityGateTitle => 'Controllo qualità acquisizione';

  @override
  String get qualityGateBody => 'Alcune condizioni di acquisizione riducono l\'affidabilità. Migliora la foto prima di fidarti dei dettagli.';

  @override
  String qualityGateScoreLine(Object percent) {
    return 'Qualità acquisizione: $percent%';
  }

  @override
  String get qualityHintCoverageLow => 'Area di scrittura troppo piccola nell\'inquadratura.';

  @override
  String get qualityHintContrastLow => 'Contrasto basso: aumenta la luce ed evita ombre.';

  @override
  String get qualityHintSharpnessLow => 'Immagine poco nitida: tieni ferma la camera e rifocalizza.';

  @override
  String get qualityHintGeneric => 'Uno o più fattori qualitativi sono sotto il livello ottimale.';

  @override
  String get qualityRetakeHint => 'Suggerimento: rifai la foto più vicina, con luce uniforme e senza riflessi.';

  @override
  String get scienceRefsTitle => 'Riferimenti scientifici';

  @override
  String get scienceRefsDisclaimer => 'Riferimenti divulgativi. L\'app non fornisce diagnosi.';

  @override
  String get openSource => 'Apri fonte';

  @override
  String get freeProTeaserTitle => 'Vuoi l\'analisi dettagliata completa?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Sblocca Pro per ottenere profilo psicologico completo, tutti i marcatori quantitativi e risultato senza pubblicità a $price.';
  }

  @override
  String get freeProTeaserButton => 'Vai all\'offerta Pro';

  @override
  String proMoreIndicatorsHint(Object count) {
    return 'Funzioni Pro: sblocca altri $count indicatori e analisi dettagliata completa.';
  }

  @override
  String get errorUnsupportedImageFormat => 'Formato immagine non supportato.';

  @override
  String get errorImageTooSmall => 'Immagine troppo piccola. Scatta una foto più vicina e nitida.';

  @override
  String get errorNotEnoughHandwriting => 'Scrittura insufficiente rilevata. Riprova con un\'inquadratura migliore.';

  @override
  String get tabFree => 'Gratis';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Condividi';

  @override
  String get legendTitle => 'Legenda psicologica semaforica';

  @override
  String get legendBody => 'Verde: equilibrio e serenità.\nArancione: tensione/vulnerabilità emotiva.\nRosso: tratti potenzialmente patologici (segnale di screening).';

  @override
  String get unlockFullPsychProfile => 'Sblocca il profilo psicologico completo';

  @override
  String get unlockFullPsychProfileBody => 'Hai già completato l’analisi. Sblocca interpretazione psicologica completa, significato semaforo e tutti i marcatori quantitativi.';

  @override
  String get valuePsychReport => 'Report psicologico completo';

  @override
  String get valueRiskMarkers => 'Marcatori di rischio potenziale';

  @override
  String get valueNoAdsThisResult => 'Niente ads su questo risultato';

  @override
  String get processing => 'Elaborazione...';

  @override
  String unlockProForPrice(Object price) {
    return 'Sblocca Pro a $price';
  }

  @override
  String get storeSetupPending => 'Configurazione prodotto store in attesa.';

  @override
  String get sharePanelText => 'Condividi su WhatsApp, Telegram, TikTok, Instagram, Facebook o share di sistema.';

  @override
  String get openPrivacyDisclaimer => 'Apri privacy e disclaimer';

  @override
  String get policyTitle => 'Privacy e Disclaimer';

  @override
  String get policyBody => 'Aggiornato: 4 marzo 2026\n\n1) Finalità e base giuridica\nUso esclusivamente divulgativo. Il trattamento si basa su consenso esplicito (GDPR Art. 6(1)(a) e, se applicabile, Art. 9(2)(a)).\n\n2) Minimizzazione dei dati\nSolo fotocamera live. Nessun accesso a galleria/file. Le foto temporanee sono eliminate in best-effort. Applicati i principi di minimizzazione e limitazione della finalità (GDPR Art. 5 e Art. 25).\n\n3) Limiti di profilazione\nNon usare l’app per assunzioni, credito, assicurazioni, ambito legale o decisioni ad alto impatto. Nessuna decisione deve basarsi solo su questo output automatizzato (GDPR Art. 22).\n\n4) Trattamenti di terze parti\nLa modalità Free usa SDK pubblicitari. Lo sblocco Pro usa billing dello store. I provider possono trattare identificativi dispositivo/transazione.\n\n5) Trasparenza\nGli utenti sono informati che interagiscono con contenuti generati da AI (principio di trasparenza AI Act Art. 50).\n\n6) Confini d’uso vietato\nL’app non deve essere usata per pratiche manipolative o simili al social scoring dannoso (AI Act Art. 5 pratiche vietate).\n\n7) Diritti utente\nL’utente può revocare il consenso in qualsiasi momento da questo pannello. Informative e diritti devono essere riportati anche nella privacy policy pubblica (GDPR Art. 13 e Artt. 15-17).\n\n8) Disclaimer medico\nNon viene fornita diagnosi medica o clinica. Un risultato rosso indica marcatori di rischio potenziale, non un disturbo confermato.\n\n9) Nota compliance\nQuesto testo in-app non costituisce consulenza legale. Prima del rilascio pubblico è necessaria revisione legale completa.';

  @override
  String get withdrawConsent => 'Revoca consenso';

  @override
  String get keepDisabled => 'Lascia disabilitato';

  @override
  String get accept => 'Accetta';

  @override
  String get signalBalance => 'Equilibrio';

  @override
  String get signalVulnerability => 'Vulnerabilità';

  @override
  String get signalPotentialPathology => 'Potenziale patologia';

  @override
  String get overallGreenTitle => 'PROFILO VERDE - Equilibrio e serenità';

  @override
  String get overallOrangeTitle => 'PROFILO ARANCIONE - Tensione e fragilità emotiva';

  @override
  String get overallRedTitle => 'PROFILO ROSSO - Tratti potenzialmente patologici';

  @override
  String get proUnlockedFullDataAvailable => 'Pro sbloccato. Dati completi disponibili.';

  @override
  String get storeProductUnavailableNow => 'Prodotto store non disponibile.';

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
  String get moreLabel => 'Altro';
}
