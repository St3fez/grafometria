// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HandwritingAnalysis';

  @override
  String get languageTooltip => 'Language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get privacyTooltip => 'Privacy and disclaimer';

  @override
  String get loadingPrivacySettings => 'Loading privacy settings...';

  @override
  String get tickConsentBeforeContinuing => 'Tick consent before continuing.';

  @override
  String get consentSavedCameraEnabled => 'Consent saved. Camera capture enabled.';

  @override
  String get analyzingPreparingResultPopup => 'Analyzing handwriting and preparing result popup...';

  @override
  String freeModeSummary(Object price) {
    return 'Free mode: ad-supported basic profile. Pro mode: full report for $price.';
  }

  @override
  String get headerSubtitle => 'Live camera analysis. Modern popup result with clear traffic-light indicators.';

  @override
  String get captureLivePhoto => 'Capture Live Photo';

  @override
  String get trustLiveCameraOnly => 'Live camera only';

  @override
  String get trustNoGalleryOrFile => 'No gallery or file intake';

  @override
  String get trustTemporaryCleanup => 'Temporary photo cleanup';

  @override
  String get consentRequiredTitle => 'Privacy and disclaimer consent required';

  @override
  String get consentRequiredBody => 'Review privacy/disclaimer before first analysis. The app is educational and non-diagnostic.';

  @override
  String get consentCheckbox => 'I have read and agree to the policy.';

  @override
  String get readPolicy => 'Read policy';

  @override
  String get acceptAndContinue => 'Accept and continue';

  @override
  String get noCaptureYet => 'No capture yet. Use live camera.';

  @override
  String get resultPopupReadyTitle => 'Your result popup is ready';

  @override
  String get proPopupReadyTitle => 'Your Pro popup report is ready';

  @override
  String get resultPopupBody => 'Open the tabbed popup for Free, Pro and Share sections.';

  @override
  String get openResultPopup => 'Open Result Popup';

  @override
  String get share => 'Share';

  @override
  String get purchaseStreamError => 'Purchase stream error.';

  @override
  String storeProductUnavailable(Object productId) {
    return 'Store product unavailable. Configure \"$productId\" first.';
  }

  @override
  String get openingSecureCheckout => 'Opening secure checkout...';

  @override
  String get proReportUnlocked => 'Pro report unlocked.';

  @override
  String get purchaseFailed => 'Purchase failed.';

  @override
  String get purchaseCanceled => 'Purchase canceled.';

  @override
  String get privacyAccepted => 'Privacy and disclaimer accepted.';

  @override
  String get consentWithdrawn => 'Consent withdrawn. Capture disabled.';

  @override
  String get shareMyResult => 'My HandwritingAnalysis result:';

  @override
  String shareConfidenceLine(Object label, Object percent) {
    return 'Confidence: $label ($percent%)';
  }

  @override
  String get shareDetailedMetricsHeader => 'Detailed metrics:';

  @override
  String get shareProHint => 'Pro unlock reveals full quantitative details.';

  @override
  String get shareTryApp => 'Try HandwritingAnalysis.';

  @override
  String get graphometryResult => 'HandwritingAnalysis Result';

  @override
  String reliabilityLine(Object label, Object percent) {
    return 'Reliability: $label ($percent%)';
  }

  @override
  String get confidenceHigh => 'High';

  @override
  String get confidenceMedium => 'Medium';

  @override
  String get confidenceLow => 'Low';

  @override
  String photoQualityShortLine(Object percent) {
    return 'Photo quality: $percent%';
  }

  @override
  String get overallSummaryGreen => 'Overall profile: centered personality, emotional steadiness, and good self-regulation.';

  @override
  String get overallSummaryOrange => 'Overall profile: sensitive personality with inner tension and emotional fluctuations.';

  @override
  String get overallSummaryRed => 'Overall profile: marked emotional dysregulation and high-risk psychological traits are emerging.';

  @override
  String get overallDescriptionGreen => 'Green profile: traits suggest stable affect, balanced impulse control, and adaptive coping under everyday stress.';

  @override
  String get overallDescriptionOrange => 'Orange profile: traits suggest high sensitivity, increased internal load, and vulnerability under pressure; relational reactivity may rise in stressful phases.';

  @override
  String get overallDescriptionRed => 'Red profile: traits suggest persistent psychological distress patterns, possible affective dysregulation, and potentially pathological markers. If this pattern repeats, seek professional evaluation.';

  @override
  String quickSummaryCompact(Object state, Object baseline, Object slant) {
    return '$state Baseline trend: $baseline. Relational style: $slant.';
  }

  @override
  String get quickBaselineUp => 'upward';

  @override
  String get quickBaselineDown => 'downward';

  @override
  String get quickBaselineStable => 'stable';

  @override
  String get quickSlantRight => 'more open';

  @override
  String get quickSlantLeft => 'more reserved';

  @override
  String get quickSlantNeutral => 'balanced';

  @override
  String detailedSpacingNarrative(Object value, Object tendency) {
    return 'Spacing ratio $value suggests $tendency.';
  }

  @override
  String get detailedSpacingAutonomy => 'a stronger autonomy boundary';

  @override
  String get detailedSpacingCloseness => 'a stronger relational closeness tendency';

  @override
  String detailedSizeNarrative(Object value, Object tendency) {
    return 'Size variance $value suggests $tendency.';
  }

  @override
  String get detailedSizeFluctuating => 'fluctuating attentional consistency';

  @override
  String get detailedSizeStable => 'a stable attentional rhythm';

  @override
  String detailedPenLiftNarrative(Object value, Object tendency) {
    return 'Pen-lift frequency $value suggests $tendency.';
  }

  @override
  String get detailedPenLiftSegmented => 'segmented cognitive sequencing';

  @override
  String get detailedPenLiftFluid => 'fluid cognitive continuity';

  @override
  String get detailedInterpretationNote => 'Interpretation note: this is a screening-style psychological reading, not a medical or psychiatric diagnosis.';

  @override
  String get metricBaselineName => 'Baseline angle';

  @override
  String get metricBaselineExplanation => 'Tracks line stability and directional drift across the writing sample.';

  @override
  String get metricBaselineRule => 'Signal rule: Green <= 4.5°, Orange <= 9°, Red > 9°.';

  @override
  String get metricSlantName => 'Slant angle';

  @override
  String get metricSlantExplanation => 'Captures emotional openness versus guarded communication style.';

  @override
  String get metricSlantRule => 'Signal rule: Green <= 12.5°, Orange <= 20°, Red > 20°.';

  @override
  String get metricPressureName => 'Pressure index';

  @override
  String get metricPressureExplanation => 'Estimates expressive force from stroke darkness and density.';

  @override
  String get metricPressureRule => 'Signal rule: Green 0.34-0.72, Orange 0.24-0.82, Red outside range.';

  @override
  String get metricSpacingName => 'Spacing ratio';

  @override
  String get metricSpacingExplanation => 'Measures average gap balance between stroke clusters.';

  @override
  String get metricSpacingRule => 'Signal rule: Green 0.82-1.55, Orange 0.60-1.95, Red outside range.';

  @override
  String get metricSizeVarianceName => 'Size variance';

  @override
  String get metricSizeVarianceExplanation => 'Reflects consistency of letter height and visual rhythm.';

  @override
  String get metricSizeVarianceRule => 'Signal rule: Green <= 0.42, Orange <= 0.66, Red > 0.66.';

  @override
  String get metricPenLiftsName => 'Pen lifts';

  @override
  String get metricPenLiftsExplanation => 'Approximates how segmented or continuous the motor sequence appears.';

  @override
  String get metricPenLiftsRule => 'Signal rule: Green <= 0.46, Orange <= 0.70, Red > 0.70.';

  @override
  String get qualityGateTitle => 'Capture quality check';

  @override
  String get qualityGateBody => 'Some capture conditions can reduce reliability. Improve framing before trusting details.';

  @override
  String qualityGateScoreLine(Object percent) {
    return 'Capture quality: $percent%';
  }

  @override
  String get qualityHintCoverageLow => 'Handwriting area is too small in frame.';

  @override
  String get qualityHintContrastLow => 'Contrast is low; increase light and avoid shadows.';

  @override
  String get qualityHintSharpnessLow => 'Image appears soft; keep camera steady and refocus.';

  @override
  String get qualityHintGeneric => 'One or more quality factors are below optimal level.';

  @override
  String get qualityRetakeHint => 'Tip: retake with closer framing, uniform light, and no glare.';

  @override
  String get scienceRefsTitle => 'Scientific references';

  @override
  String get scienceRefsDisclaimer => 'Educational references only. This app does not provide diagnosis.';

  @override
  String get openSource => 'Open source';

  @override
  String get freeProTeaserTitle => 'Want the full detailed analysis?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Unlock Pro to access complete psychological profile, all quantitative markers, and ad-free result at $price.';
  }

  @override
  String get freeProTeaserButton => 'See Pro offer';

  @override
  String proMoreIndicatorsHint(Object count) {
    return 'Pro functions: unlock $count additional indicators and full detailed analysis.';
  }

  @override
  String get errorUnsupportedImageFormat => 'Unsupported image format.';

  @override
  String get errorImageTooSmall => 'Image too small. Capture a closer and sharper photo.';

  @override
  String get errorNotEnoughHandwriting => 'Not enough handwriting detected. Try with better framing.';

  @override
  String get tabFree => 'Free';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Share';

  @override
  String get legendTitle => 'Psychological traffic-light legend';

  @override
  String get legendBody => 'Green: equilibrium and serenity.\nOrange: emotional tension/vulnerability.\nRed: potentially pathological traits (screening signal).';

  @override
  String get unlockFullPsychProfile => 'Unlock the full psychological profile';

  @override
  String get unlockFullPsychProfileBody => 'You already completed analysis. Unlock complete psychological interpretation, semaforo meaning, and full quantitative markers.';

  @override
  String get valuePsychReport => 'Psychological full report';

  @override
  String get valueRiskMarkers => 'Potential risk markers';

  @override
  String get valueNoAdsThisResult => 'No ads for this result';

  @override
  String get processing => 'Processing...';

  @override
  String unlockProForPrice(Object price) {
    return 'Unlock Pro for $price';
  }

  @override
  String get storeSetupPending => 'Store product setup pending.';

  @override
  String get sharePanelText => 'Share on WhatsApp, Telegram, TikTok, Instagram, Facebook or system share.';

  @override
  String get openPrivacyDisclaimer => 'Open privacy and disclaimer';

  @override
  String get policyTitle => 'Privacy and Disclaimer';

  @override
  String get policyBody => 'Updated: March 4, 2026\n\n1) Purpose and legal basis\nEducational use only. Processing is based on explicit consent (GDPR Art. 6(1)(a) and, where applicable, Art. 9(2)(a)).\n\n2) Data minimization\nLive camera only. No gallery/file intake. Temporary photos are deleted on a best-effort basis. Data-minimization and purpose-limitation principles are applied (GDPR Art. 5 and Art. 25).\n\n3) Profiling limits\nDo not use this app for hiring, credit, insurance, legal or high-impact decisions. No decision should be made solely on this automated output (GDPR Art. 22).\n\n4) Third-party processing\nFree mode uses ad SDKs. Pro unlock uses store billing. Providers may process device/transaction identifiers.\n\n5) Transparency\nUsers are informed that they are interacting with AI-generated content (AI Act Art. 50 transparency principle).\n\n6) Prohibited-use boundaries\nThe app must not be used for manipulative or harmful social-scoring-like uses (AI Act Art. 5 prohibited practices).\n\n7) User rights\nUsers can withdraw consent at any time from this panel. Information duties and rights should be reflected in store-facing privacy notice (GDPR Art. 13 and Arts. 15-17).\n\n8) Medical disclaimer\nNo medical or clinical diagnosis is provided. A red result indicates potential risk markers, not a confirmed disorder.\n\n9) Compliance note\nThis in-app text is not legal advice. Complete legal review before public release.';

  @override
  String get withdrawConsent => 'Withdraw consent';

  @override
  String get keepDisabled => 'Keep disabled';

  @override
  String get accept => 'Accept';

  @override
  String get signalBalance => 'Balance';

  @override
  String get signalVulnerability => 'Vulnerability';

  @override
  String get signalPotentialPathology => 'Potential pathology';

  @override
  String get overallGreenTitle => 'GREEN PROFILE - Equilibrium and serenity';

  @override
  String get overallOrangeTitle => 'ORANGE PROFILE - Emotional tension and fragility';

  @override
  String get overallRedTitle => 'RED PROFILE - Potentially pathological traits';

  @override
  String get proUnlockedFullDataAvailable => 'Pro unlocked. Full data available.';

  @override
  String get storeProductUnavailableNow => 'Store product unavailable.';

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
  String get moreLabel => 'More';
}
