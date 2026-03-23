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
  String get overallSummaryGreen => 'Regular sample: balanced graphic pattern and no strong load markers.';

  @override
  String get overallSummaryOrange => 'Variable sample: stress sensitivity and tension should be read cautiously.';

  @override
  String get overallSummaryRed => 'Heavier or discontinuous sample: possible fatigue and tension markers.';

  @override
  String get overallDescriptionGreen => 'Green profile: this sample sits in the more regular range, with steadier rhythm, contained activation, and an overall more ordered visual execution.';

  @override
  String get overallDescriptionOrange => 'Orange profile: this sample shows more variability, possible sensitivity to situational pressure, and rhythm fluctuations that should be contextualized with other observations.';

  @override
  String get overallDescriptionRed => 'Red profile: this sample shows higher graphic load or marked discontinuity. These markers may accompany tension, fatigue, or unstable execution, but they are not a diagnosis.';

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
  String psychologicalSnapshot(Object baseline, Object slant, Object pressure, Object spacing, Object rhythm) {
    return 'Cautious psychological reading: baseline $baseline, slant $slant, pressure suggests $pressure, spacing is compatible with $spacing, and the writing rhythm looks closer to $rhythm.';
  }

  @override
  String get psychPressureHigh => 'higher internal activation';

  @override
  String get psychPressureBalanced => 'fairly balanced tonic modulation';

  @override
  String get psychPressureLow => 'contained activation or lighter stroke';

  @override
  String get confidenceAdviceHigh => 'Reliability is good for an exploratory reading, but the image remains only a visual clue.';

  @override
  String get confidenceAdviceMedium => 'Reliability is moderate: use the result as a prompt, not as a conclusion.';

  @override
  String get confidenceAdviceLow => 'Reliability is low: retake the photo and compare multiple samples before interpreting it.';

  @override
  String get wellbeingSuggestionTitle => 'Wellbeing suggestion';

  @override
  String get wellbeingSuggestionGreen => 'If the sample feels coherent, protect that balance with simple routines: regular sleep, short breaks, and slower writing without hurry.';

  @override
  String get wellbeingSuggestionOrange => 'If tension feels recurrent, try short breaks, slower breathing, less haste, and a few lines of journaling to discharge some load.';

  @override
  String get wellbeingSuggestionRed => 'If these signs repeat across samples or with real distress, reduce overload, protect sleep and breaks, and consider talking to a qualified professional.';

  @override
  String get detailedInterpretationNote => 'Interpretation note: graphomotor markers may describe gesture quality, but personality graphology lacks robust validation; this reading remains exploratory and non-diagnostic.';

  @override
  String get psychCuesTitle => 'Exploratory psychological cues';

  @override
  String get psychCuesBody => 'These are orientation labels derived from pressure, regularity, and rhythm of the gesture. They make the profile feel more psychological, but they do not define the person with certainty.';

  @override
  String get psychCueSerenity => 'Serenity';

  @override
  String get psychCueSerenityDetail => 'The gesture looks well regulated, with contained load and fairly orderly continuity.';

  @override
  String get psychCueActivation => 'Activation';

  @override
  String get psychCueActivationDetail => 'Energy is present but not extreme; the sample should be read in light of context and moment.';

  @override
  String get psychCueStress => 'Stress';

  @override
  String get psychCueStressDetail => 'Higher pressure or fragmentation can accompany situational tension and overload.';

  @override
  String get psychCueStability => 'Stability';

  @override
  String get psychCueStabilityDetail => 'Line and proportions stay fairly coherent, suggesting a more stable gesture setting.';

  @override
  String get psychCueSensitivity => 'Sensitivity';

  @override
  String get psychCueSensitivityDetail => 'Small oscillations in the gesture may reflect contextual reactivity or momentary variability.';

  @override
  String get psychCueDiscontinuity => 'Discontinuity';

  @override
  String get psychCueDiscontinuityDetail => 'Marked shifts in the gesture can indicate a less regular sample pattern.';

  @override
  String get psychCueFluidity => 'Fluidity';

  @override
  String get psychCueFluidityDetail => 'The writing sequence appears fairly continuous and only lightly interrupted.';

  @override
  String get psychCueVariability => 'Variability';

  @override
  String get psychCueVariabilityDetail => 'The rhythm alternates between more continuous passages and more controlled or segmented ones.';

  @override
  String get psychCueFragmentation => 'Fragmentation';

  @override
  String get psychCueFragmentationDetail => 'The rhythm appears more interrupted or broken, with lower motor continuity.';

  @override
  String get metricBaselineName => 'Baseline angle';

  @override
  String get metricBaselineExplanation => 'Tracks line stability and directional drift across the writing sample.';

  @override
  String get metricBaselineRule => 'Signal rule: Green <= 4.0°, Orange <= 8.1°, Red > 8.1°.';

  @override
  String get metricSlantName => 'Slant angle';

  @override
  String get metricSlantExplanation => 'Captures emotional openness versus guarded communication style.';

  @override
  String get metricSlantRule => 'Signal rule: Green <= 11.3°, Orange <= 18.0°, Red > 18.0°.';

  @override
  String get metricPressureName => 'Pressure index';

  @override
  String get metricPressureExplanation => 'Estimates expressive force from stroke darkness and density.';

  @override
  String get metricPressureRule => 'Signal rule: Green 0.38-0.68, Orange 0.28-0.78, Red outside range.';

  @override
  String get metricSpacingName => 'Spacing ratio';

  @override
  String get metricSpacingExplanation => 'Measures average gap balance between stroke clusters.';

  @override
  String get metricSpacingRule => 'Signal rule: Green 0.89-1.48, Orange 0.66-1.82, Red outside range.';

  @override
  String get metricSizeVarianceName => 'Size variance';

  @override
  String get metricSizeVarianceExplanation => 'Reflects consistency of letter height and visual rhythm.';

  @override
  String get metricSizeVarianceRule => 'Signal rule: Green <= 0.38, Orange <= 0.59, Red > 0.59.';

  @override
  String get metricPenLiftsName => 'Pen lifts';

  @override
  String get metricPenLiftsExplanation => 'Approximates how segmented or continuous the motor sequence appears.';

  @override
  String get metricPenLiftsRule => 'Signal rule: Green <= 0.41, Orange <= 0.63, Red > 0.63.';

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
  String get scienceRefsDisclaimer => 'Primary sources across three areas: limits of personality graphology, graphomotor markers in motor-cognitive settings, and modest potential benefits of expressive writing. They do not validate diagnosis or individual psychological profiling from a single sample.';

  @override
  String get openSource => 'Open source';

  @override
  String get freeProTeaserTitle => 'Want the full detailed analysis?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Unlock Pro to access a more detailed exploratory reading, all quantitative markers, and an ad-free result at $price.';
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
  String get errorHandwritingRequired => 'Photograph handwritten text. Retry.';

  @override
  String get tabFree => 'Free';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Share';

  @override
  String get legendTitle => 'Psychological traffic-light legend';

  @override
  String get legendBody => 'Green: more regular and less loaded pattern.\nOrange: variability and tension to contextualize.\nRed: greater discontinuity or graphic load; not a diagnosis.';

  @override
  String get unlockFullPsychProfile => 'Unlock the detailed reading';

  @override
  String get unlockFullPsychProfileBody => 'You already completed analysis. Unlock a more detailed exploratory reading, semaforo meaning, and full quantitative markers.';

  @override
  String get valuePsychReport => 'Detailed exploratory report';

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
  String get signalPotentialPathology => 'Higher load';

  @override
  String get overallGreenTitle => 'GREEN PROFILE - More regular sample';

  @override
  String get overallOrangeTitle => 'ORANGE PROFILE - Variability and tension';

  @override
  String get overallRedTitle => 'RED PROFILE - Load or discontinuity';

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
