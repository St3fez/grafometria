import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HandwritingAnalysis'**
  String get appTitle;

  /// No description provided for @languageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTooltip;

  /// No description provided for @languageSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// No description provided for @privacyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Privacy and disclaimer'**
  String get privacyTooltip;

  /// No description provided for @loadingPrivacySettings.
  ///
  /// In en, this message translates to:
  /// **'Loading privacy settings...'**
  String get loadingPrivacySettings;

  /// No description provided for @tickConsentBeforeContinuing.
  ///
  /// In en, this message translates to:
  /// **'Tick consent before continuing.'**
  String get tickConsentBeforeContinuing;

  /// No description provided for @consentSavedCameraEnabled.
  ///
  /// In en, this message translates to:
  /// **'Consent saved. Camera capture enabled.'**
  String get consentSavedCameraEnabled;

  /// No description provided for @analyzingPreparingResultPopup.
  ///
  /// In en, this message translates to:
  /// **'Analyzing handwriting and preparing result popup...'**
  String get analyzingPreparingResultPopup;

  /// No description provided for @freeModeSummary.
  ///
  /// In en, this message translates to:
  /// **'Free mode: ad-supported basic profile. Pro mode: full report for {price}.'**
  String freeModeSummary(Object price);

  /// No description provided for @headerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Live camera analysis. Modern popup result with clear traffic-light indicators.'**
  String get headerSubtitle;

  /// No description provided for @captureLivePhoto.
  ///
  /// In en, this message translates to:
  /// **'Capture Live Photo'**
  String get captureLivePhoto;

  /// No description provided for @trustLiveCameraOnly.
  ///
  /// In en, this message translates to:
  /// **'Live camera only'**
  String get trustLiveCameraOnly;

  /// No description provided for @trustNoGalleryOrFile.
  ///
  /// In en, this message translates to:
  /// **'No gallery or file intake'**
  String get trustNoGalleryOrFile;

  /// No description provided for @trustTemporaryCleanup.
  ///
  /// In en, this message translates to:
  /// **'Temporary photo cleanup'**
  String get trustTemporaryCleanup;

  /// No description provided for @consentRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and disclaimer consent required'**
  String get consentRequiredTitle;

  /// No description provided for @consentRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'Review privacy/disclaimer before first analysis. The app is educational and non-diagnostic.'**
  String get consentRequiredBody;

  /// No description provided for @consentCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the policy.'**
  String get consentCheckbox;

  /// No description provided for @readPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read policy'**
  String get readPolicy;

  /// No description provided for @acceptAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Accept and continue'**
  String get acceptAndContinue;

  /// No description provided for @noCaptureYet.
  ///
  /// In en, this message translates to:
  /// **'No capture yet. Use live camera.'**
  String get noCaptureYet;

  /// No description provided for @resultPopupReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your result popup is ready'**
  String get resultPopupReadyTitle;

  /// No description provided for @proPopupReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Pro popup report is ready'**
  String get proPopupReadyTitle;

  /// No description provided for @resultPopupBody.
  ///
  /// In en, this message translates to:
  /// **'Open the tabbed popup for Free, Pro and Share sections.'**
  String get resultPopupBody;

  /// No description provided for @openResultPopup.
  ///
  /// In en, this message translates to:
  /// **'Open Result Popup'**
  String get openResultPopup;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @purchaseStreamError.
  ///
  /// In en, this message translates to:
  /// **'Purchase stream error.'**
  String get purchaseStreamError;

  /// No description provided for @storeProductUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Store product unavailable. Configure \"{productId}\" first.'**
  String storeProductUnavailable(Object productId);

  /// No description provided for @openingSecureCheckout.
  ///
  /// In en, this message translates to:
  /// **'Opening secure checkout...'**
  String get openingSecureCheckout;

  /// No description provided for @proReportUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Pro report unlocked.'**
  String get proReportUnlocked;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed.'**
  String get purchaseFailed;

  /// No description provided for @purchaseCanceled.
  ///
  /// In en, this message translates to:
  /// **'Purchase canceled.'**
  String get purchaseCanceled;

  /// No description provided for @privacyAccepted.
  ///
  /// In en, this message translates to:
  /// **'Privacy and disclaimer accepted.'**
  String get privacyAccepted;

  /// No description provided for @consentWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Consent withdrawn. Capture disabled.'**
  String get consentWithdrawn;

  /// No description provided for @shareMyResult.
  ///
  /// In en, this message translates to:
  /// **'My HandwritingAnalysis result:'**
  String get shareMyResult;

  /// No description provided for @shareConfidenceLine.
  ///
  /// In en, this message translates to:
  /// **'Confidence: {label} ({percent}%)'**
  String shareConfidenceLine(Object label, Object percent);

  /// No description provided for @shareDetailedMetricsHeader.
  ///
  /// In en, this message translates to:
  /// **'Detailed metrics:'**
  String get shareDetailedMetricsHeader;

  /// No description provided for @shareProHint.
  ///
  /// In en, this message translates to:
  /// **'Pro unlock reveals full quantitative details.'**
  String get shareProHint;

  /// No description provided for @shareTryApp.
  ///
  /// In en, this message translates to:
  /// **'Try HandwritingAnalysis.'**
  String get shareTryApp;

  /// No description provided for @graphometryResult.
  ///
  /// In en, this message translates to:
  /// **'HandwritingAnalysis Result'**
  String get graphometryResult;

  /// No description provided for @reliabilityLine.
  ///
  /// In en, this message translates to:
  /// **'Reliability: {label} ({percent}%)'**
  String reliabilityLine(Object label, Object percent);

  /// No description provided for @confidenceHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get confidenceHigh;

  /// No description provided for @confidenceMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get confidenceMedium;

  /// No description provided for @confidenceLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get confidenceLow;

  /// No description provided for @photoQualityShortLine.
  ///
  /// In en, this message translates to:
  /// **'Photo quality: {percent}%'**
  String photoQualityShortLine(Object percent);

  /// No description provided for @overallSummaryGreen.
  ///
  /// In en, this message translates to:
  /// **'Overall profile: centered personality, emotional steadiness, and good self-regulation.'**
  String get overallSummaryGreen;

  /// No description provided for @overallSummaryOrange.
  ///
  /// In en, this message translates to:
  /// **'Overall profile: sensitive personality with inner tension and emotional fluctuations.'**
  String get overallSummaryOrange;

  /// No description provided for @overallSummaryRed.
  ///
  /// In en, this message translates to:
  /// **'Overall profile: marked emotional dysregulation and high-risk psychological traits are emerging.'**
  String get overallSummaryRed;

  /// No description provided for @overallDescriptionGreen.
  ///
  /// In en, this message translates to:
  /// **'Green profile: traits suggest stable affect, balanced impulse control, and adaptive coping under everyday stress.'**
  String get overallDescriptionGreen;

  /// No description provided for @overallDescriptionOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange profile: traits suggest high sensitivity, increased internal load, and vulnerability under pressure; relational reactivity may rise in stressful phases.'**
  String get overallDescriptionOrange;

  /// No description provided for @overallDescriptionRed.
  ///
  /// In en, this message translates to:
  /// **'Red profile: traits suggest persistent psychological distress patterns, possible affective dysregulation, and potentially pathological markers. If this pattern repeats, seek professional evaluation.'**
  String get overallDescriptionRed;

  /// No description provided for @quickSummaryCompact.
  ///
  /// In en, this message translates to:
  /// **'{state} Baseline trend: {baseline}. Relational style: {slant}.'**
  String quickSummaryCompact(Object state, Object baseline, Object slant);

  /// No description provided for @quickBaselineUp.
  ///
  /// In en, this message translates to:
  /// **'upward'**
  String get quickBaselineUp;

  /// No description provided for @quickBaselineDown.
  ///
  /// In en, this message translates to:
  /// **'downward'**
  String get quickBaselineDown;

  /// No description provided for @quickBaselineStable.
  ///
  /// In en, this message translates to:
  /// **'stable'**
  String get quickBaselineStable;

  /// No description provided for @quickSlantRight.
  ///
  /// In en, this message translates to:
  /// **'more open'**
  String get quickSlantRight;

  /// No description provided for @quickSlantLeft.
  ///
  /// In en, this message translates to:
  /// **'more reserved'**
  String get quickSlantLeft;

  /// No description provided for @quickSlantNeutral.
  ///
  /// In en, this message translates to:
  /// **'balanced'**
  String get quickSlantNeutral;

  /// No description provided for @detailedSpacingNarrative.
  ///
  /// In en, this message translates to:
  /// **'Spacing ratio {value} suggests {tendency}.'**
  String detailedSpacingNarrative(Object value, Object tendency);

  /// No description provided for @detailedSpacingAutonomy.
  ///
  /// In en, this message translates to:
  /// **'a stronger autonomy boundary'**
  String get detailedSpacingAutonomy;

  /// No description provided for @detailedSpacingCloseness.
  ///
  /// In en, this message translates to:
  /// **'a stronger relational closeness tendency'**
  String get detailedSpacingCloseness;

  /// No description provided for @detailedSizeNarrative.
  ///
  /// In en, this message translates to:
  /// **'Size variance {value} suggests {tendency}.'**
  String detailedSizeNarrative(Object value, Object tendency);

  /// No description provided for @detailedSizeFluctuating.
  ///
  /// In en, this message translates to:
  /// **'fluctuating attentional consistency'**
  String get detailedSizeFluctuating;

  /// No description provided for @detailedSizeStable.
  ///
  /// In en, this message translates to:
  /// **'a stable attentional rhythm'**
  String get detailedSizeStable;

  /// No description provided for @detailedPenLiftNarrative.
  ///
  /// In en, this message translates to:
  /// **'Pen-lift frequency {value} suggests {tendency}.'**
  String detailedPenLiftNarrative(Object value, Object tendency);

  /// No description provided for @detailedPenLiftSegmented.
  ///
  /// In en, this message translates to:
  /// **'segmented cognitive sequencing'**
  String get detailedPenLiftSegmented;

  /// No description provided for @detailedPenLiftFluid.
  ///
  /// In en, this message translates to:
  /// **'fluid cognitive continuity'**
  String get detailedPenLiftFluid;

  /// No description provided for @detailedInterpretationNote.
  ///
  /// In en, this message translates to:
  /// **'Interpretation note: this is a screening-style psychological reading, not a medical or psychiatric diagnosis.'**
  String get detailedInterpretationNote;

  /// No description provided for @metricBaselineName.
  ///
  /// In en, this message translates to:
  /// **'Baseline angle'**
  String get metricBaselineName;

  /// No description provided for @metricBaselineExplanation.
  ///
  /// In en, this message translates to:
  /// **'Tracks line stability and directional drift across the writing sample.'**
  String get metricBaselineExplanation;

  /// No description provided for @metricBaselineRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green <= 4.5°, Orange <= 9°, Red > 9°.'**
  String get metricBaselineRule;

  /// No description provided for @metricSlantName.
  ///
  /// In en, this message translates to:
  /// **'Slant angle'**
  String get metricSlantName;

  /// No description provided for @metricSlantExplanation.
  ///
  /// In en, this message translates to:
  /// **'Captures emotional openness versus guarded communication style.'**
  String get metricSlantExplanation;

  /// No description provided for @metricSlantRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green <= 12.5°, Orange <= 20°, Red > 20°.'**
  String get metricSlantRule;

  /// No description provided for @metricPressureName.
  ///
  /// In en, this message translates to:
  /// **'Pressure index'**
  String get metricPressureName;

  /// No description provided for @metricPressureExplanation.
  ///
  /// In en, this message translates to:
  /// **'Estimates expressive force from stroke darkness and density.'**
  String get metricPressureExplanation;

  /// No description provided for @metricPressureRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green 0.34-0.72, Orange 0.24-0.82, Red outside range.'**
  String get metricPressureRule;

  /// No description provided for @metricSpacingName.
  ///
  /// In en, this message translates to:
  /// **'Spacing ratio'**
  String get metricSpacingName;

  /// No description provided for @metricSpacingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Measures average gap balance between stroke clusters.'**
  String get metricSpacingExplanation;

  /// No description provided for @metricSpacingRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green 0.82-1.55, Orange 0.60-1.95, Red outside range.'**
  String get metricSpacingRule;

  /// No description provided for @metricSizeVarianceName.
  ///
  /// In en, this message translates to:
  /// **'Size variance'**
  String get metricSizeVarianceName;

  /// No description provided for @metricSizeVarianceExplanation.
  ///
  /// In en, this message translates to:
  /// **'Reflects consistency of letter height and visual rhythm.'**
  String get metricSizeVarianceExplanation;

  /// No description provided for @metricSizeVarianceRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green <= 0.42, Orange <= 0.66, Red > 0.66.'**
  String get metricSizeVarianceRule;

  /// No description provided for @metricPenLiftsName.
  ///
  /// In en, this message translates to:
  /// **'Pen lifts'**
  String get metricPenLiftsName;

  /// No description provided for @metricPenLiftsExplanation.
  ///
  /// In en, this message translates to:
  /// **'Approximates how segmented or continuous the motor sequence appears.'**
  String get metricPenLiftsExplanation;

  /// No description provided for @metricPenLiftsRule.
  ///
  /// In en, this message translates to:
  /// **'Signal rule: Green <= 0.46, Orange <= 0.70, Red > 0.70.'**
  String get metricPenLiftsRule;

  /// No description provided for @qualityGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture quality check'**
  String get qualityGateTitle;

  /// No description provided for @qualityGateBody.
  ///
  /// In en, this message translates to:
  /// **'Some capture conditions can reduce reliability. Improve framing before trusting details.'**
  String get qualityGateBody;

  /// No description provided for @qualityGateScoreLine.
  ///
  /// In en, this message translates to:
  /// **'Capture quality: {percent}%'**
  String qualityGateScoreLine(Object percent);

  /// No description provided for @qualityHintCoverageLow.
  ///
  /// In en, this message translates to:
  /// **'Handwriting area is too small in frame.'**
  String get qualityHintCoverageLow;

  /// No description provided for @qualityHintContrastLow.
  ///
  /// In en, this message translates to:
  /// **'Contrast is low; increase light and avoid shadows.'**
  String get qualityHintContrastLow;

  /// No description provided for @qualityHintSharpnessLow.
  ///
  /// In en, this message translates to:
  /// **'Image appears soft; keep camera steady and refocus.'**
  String get qualityHintSharpnessLow;

  /// No description provided for @qualityHintGeneric.
  ///
  /// In en, this message translates to:
  /// **'One or more quality factors are below optimal level.'**
  String get qualityHintGeneric;

  /// No description provided for @qualityRetakeHint.
  ///
  /// In en, this message translates to:
  /// **'Tip: retake with closer framing, uniform light, and no glare.'**
  String get qualityRetakeHint;

  /// No description provided for @scienceRefsTitle.
  ///
  /// In en, this message translates to:
  /// **'Scientific references'**
  String get scienceRefsTitle;

  /// No description provided for @scienceRefsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Educational references only. This app does not provide diagnosis.'**
  String get scienceRefsDisclaimer;

  /// No description provided for @openSource.
  ///
  /// In en, this message translates to:
  /// **'Open source'**
  String get openSource;

  /// No description provided for @freeProTeaserTitle.
  ///
  /// In en, this message translates to:
  /// **'Want the full detailed analysis?'**
  String get freeProTeaserTitle;

  /// No description provided for @freeProTeaserBody.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro to access complete psychological profile, all quantitative markers, and ad-free result at {price}.'**
  String freeProTeaserBody(Object price);

  /// No description provided for @freeProTeaserButton.
  ///
  /// In en, this message translates to:
  /// **'See Pro offer'**
  String get freeProTeaserButton;

  /// No description provided for @proMoreIndicatorsHint.
  ///
  /// In en, this message translates to:
  /// **'Pro functions: unlock {count} additional indicators and full detailed analysis.'**
  String proMoreIndicatorsHint(Object count);

  /// No description provided for @errorUnsupportedImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported image format.'**
  String get errorUnsupportedImageFormat;

  /// No description provided for @errorImageTooSmall.
  ///
  /// In en, this message translates to:
  /// **'Image too small. Capture a closer and sharper photo.'**
  String get errorImageTooSmall;

  /// No description provided for @errorNotEnoughHandwriting.
  ///
  /// In en, this message translates to:
  /// **'Not enough handwriting detected. Try with better framing.'**
  String get errorNotEnoughHandwriting;

  /// No description provided for @tabFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get tabFree;

  /// No description provided for @tabPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get tabPro;

  /// No description provided for @tabShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get tabShare;

  /// No description provided for @legendTitle.
  ///
  /// In en, this message translates to:
  /// **'Psychological traffic-light legend'**
  String get legendTitle;

  /// No description provided for @legendBody.
  ///
  /// In en, this message translates to:
  /// **'Green: equilibrium and serenity.\nOrange: emotional tension/vulnerability.\nRed: potentially pathological traits (screening signal).'**
  String get legendBody;

  /// No description provided for @unlockFullPsychProfile.
  ///
  /// In en, this message translates to:
  /// **'Unlock the full psychological profile'**
  String get unlockFullPsychProfile;

  /// No description provided for @unlockFullPsychProfileBody.
  ///
  /// In en, this message translates to:
  /// **'You already completed analysis. Unlock complete psychological interpretation, semaforo meaning, and full quantitative markers.'**
  String get unlockFullPsychProfileBody;

  /// No description provided for @valuePsychReport.
  ///
  /// In en, this message translates to:
  /// **'Psychological full report'**
  String get valuePsychReport;

  /// No description provided for @valueRiskMarkers.
  ///
  /// In en, this message translates to:
  /// **'Potential risk markers'**
  String get valueRiskMarkers;

  /// No description provided for @valueNoAdsThisResult.
  ///
  /// In en, this message translates to:
  /// **'No ads for this result'**
  String get valueNoAdsThisResult;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @unlockProForPrice.
  ///
  /// In en, this message translates to:
  /// **'Unlock Pro for {price}'**
  String unlockProForPrice(Object price);

  /// No description provided for @storeSetupPending.
  ///
  /// In en, this message translates to:
  /// **'Store product setup pending.'**
  String get storeSetupPending;

  /// No description provided for @sharePanelText.
  ///
  /// In en, this message translates to:
  /// **'Share on WhatsApp, Telegram, TikTok, Instagram, Facebook or system share.'**
  String get sharePanelText;

  /// No description provided for @openPrivacyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Open privacy and disclaimer'**
  String get openPrivacyDisclaimer;

  /// No description provided for @policyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy and Disclaimer'**
  String get policyTitle;

  /// No description provided for @policyBody.
  ///
  /// In en, this message translates to:
  /// **'Updated: March 4, 2026\n\n1) Purpose and legal basis\nEducational use only. Processing is based on explicit consent (GDPR Art. 6(1)(a) and, where applicable, Art. 9(2)(a)).\n\n2) Data minimization\nLive camera only. No gallery/file intake. Temporary photos are deleted on a best-effort basis. Data-minimization and purpose-limitation principles are applied (GDPR Art. 5 and Art. 25).\n\n3) Profiling limits\nDo not use this app for hiring, credit, insurance, legal or high-impact decisions. No decision should be made solely on this automated output (GDPR Art. 22).\n\n4) Third-party processing\nFree mode uses ad SDKs. Pro unlock uses store billing. Providers may process device/transaction identifiers.\n\n5) Transparency\nUsers are informed that they are interacting with AI-generated content (AI Act Art. 50 transparency principle).\n\n6) Prohibited-use boundaries\nThe app must not be used for manipulative or harmful social-scoring-like uses (AI Act Art. 5 prohibited practices).\n\n7) User rights\nUsers can withdraw consent at any time from this panel. Information duties and rights should be reflected in store-facing privacy notice (GDPR Art. 13 and Arts. 15-17).\n\n8) Medical disclaimer\nNo medical or clinical diagnosis is provided. A red result indicates potential risk markers, not a confirmed disorder.\n\n9) Compliance note\nThis in-app text is not legal advice. Complete legal review before public release.'**
  String get policyBody;

  /// No description provided for @withdrawConsent.
  ///
  /// In en, this message translates to:
  /// **'Withdraw consent'**
  String get withdrawConsent;

  /// No description provided for @keepDisabled.
  ///
  /// In en, this message translates to:
  /// **'Keep disabled'**
  String get keepDisabled;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @signalBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get signalBalance;

  /// No description provided for @signalVulnerability.
  ///
  /// In en, this message translates to:
  /// **'Vulnerability'**
  String get signalVulnerability;

  /// No description provided for @signalPotentialPathology.
  ///
  /// In en, this message translates to:
  /// **'Potential pathology'**
  String get signalPotentialPathology;

  /// No description provided for @overallGreenTitle.
  ///
  /// In en, this message translates to:
  /// **'GREEN PROFILE - Equilibrium and serenity'**
  String get overallGreenTitle;

  /// No description provided for @overallOrangeTitle.
  ///
  /// In en, this message translates to:
  /// **'ORANGE PROFILE - Emotional tension and fragility'**
  String get overallOrangeTitle;

  /// No description provided for @overallRedTitle.
  ///
  /// In en, this message translates to:
  /// **'RED PROFILE - Potentially pathological traits'**
  String get overallRedTitle;

  /// No description provided for @proUnlockedFullDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'Pro unlocked. Full data available.'**
  String get proUnlockedFullDataAvailable;

  /// No description provided for @storeProductUnavailableNow.
  ///
  /// In en, this message translates to:
  /// **'Store product unavailable.'**
  String get storeProductUnavailableNow;

  /// No description provided for @whatsappLabel.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsappLabel;

  /// No description provided for @telegramLabel.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegramLabel;

  /// No description provided for @tiktokLabel.
  ///
  /// In en, this message translates to:
  /// **'TikTok'**
  String get tiktokLabel;

  /// No description provided for @instagramLabel.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagramLabel;

  /// No description provided for @facebookLabel.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebookLabel;

  /// No description provided for @moreLabel.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
