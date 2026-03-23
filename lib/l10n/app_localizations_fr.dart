// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'HandwritingAnalysis';

  @override
  String get languageTooltip => 'Langue';

  @override
  String get languageSystemDefault => 'Par defaut du systeme';

  @override
  String get privacyTooltip => 'Confidentialite et avertissement';

  @override
  String get loadingPrivacySettings => 'Chargement des parametres de confidentialite...';

  @override
  String get tickConsentBeforeContinuing => 'Cochez le consentement avant de continuer.';

  @override
  String get consentSavedCameraEnabled => 'Consentement enregistre. Capture camera activee.';

  @override
  String get analyzingPreparingResultPopup => 'Analyse de l\'ecriture et preparation de la fenetre de resultat...';

  @override
  String freeModeSummary(Object price) {
    return 'Mode gratuit : profil de base avec publicite. Mode Pro : rapport complet pour $price.';
  }

  @override
  String get headerSubtitle => 'Analyse via camera en direct. Resultat en fenetre moderne avec indicateurs type feu tricolore.';

  @override
  String get captureLivePhoto => 'Capturer une photo en direct';

  @override
  String get trustLiveCameraOnly => 'Camera en direct uniquement';

  @override
  String get trustNoGalleryOrFile => 'Aucune galerie ni fichier';

  @override
  String get trustTemporaryCleanup => 'Suppression temporaire des photos';

  @override
  String get consentRequiredTitle => 'Consentement confidentialite et avertissement requis';

  @override
  String get consentRequiredBody => 'Consultez la confidentialite/l\'avertissement avant la premiere analyse. L\'app est educative et non diagnostique.';

  @override
  String get consentCheckbox => 'J\'ai lu et j\'accepte la politique.';

  @override
  String get readPolicy => 'Lire la politique';

  @override
  String get acceptAndContinue => 'Accepter et continuer';

  @override
  String get noCaptureYet => 'Aucune capture pour le moment. Utilisez la camera en direct.';

  @override
  String get resultPopupReadyTitle => 'Votre fenetre de resultat est prete';

  @override
  String get proPopupReadyTitle => 'Votre rapport Pro en fenetre est pret';

  @override
  String get resultPopupBody => 'Ouvrez la fenetre a onglets pour les sections Gratuit, Pro et Partage.';

  @override
  String get openResultPopup => 'Ouvrir le resultat';

  @override
  String get share => 'Partager';

  @override
  String get purchaseStreamError => 'Erreur du flux d\'achat.';

  @override
  String storeProductUnavailable(Object productId) {
    return 'Produit boutique indisponible. Configurez d\'abord \"$productId\".';
  }

  @override
  String get openingSecureCheckout => 'Ouverture du paiement securise...';

  @override
  String get proReportUnlocked => 'Rapport Pro debloque.';

  @override
  String get purchaseFailed => 'Echec de l\'achat.';

  @override
  String get purchaseCanceled => 'Achat annule.';

  @override
  String get privacyAccepted => 'Confidentialite et avertissement acceptes.';

  @override
  String get consentWithdrawn => 'Consentement retire. Capture desactivee.';

  @override
  String get shareMyResult => 'Mon resultat HandwritingAnalysis :';

  @override
  String shareConfidenceLine(Object label, Object percent) {
    return 'Confiance : $label ($percent%)';
  }

  @override
  String get shareDetailedMetricsHeader => 'Metriques detaillees :';

  @override
  String get shareProHint => 'Le debloquage Pro revele tous les details quantitatifs.';

  @override
  String get shareTryApp => 'Essayez HandwritingAnalysis.';

  @override
  String get graphometryResult => 'Resultat HandwritingAnalysis';

  @override
  String reliabilityLine(Object label, Object percent) {
    return 'Fiabilite : $label ($percent%)';
  }

  @override
  String get confidenceHigh => 'Elevee';

  @override
  String get confidenceMedium => 'Moyenne';

  @override
  String get confidenceLow => 'Faible';

  @override
  String photoQualityShortLine(Object percent) {
    return 'Qualite photo : $percent%';
  }

  @override
  String get overallSummaryGreen => 'Echantillon regulier : motif graphique equilibre et sans forte charge.';

  @override
  String get overallSummaryOrange => 'Echantillon variable : sensibilite au stress et tension a lire avec prudence.';

  @override
  String get overallSummaryRed => 'Echantillon plus charge ou discontinu : possibles marqueurs de fatigue et de tension.';

  @override
  String get overallDescriptionGreen => 'Profil vert : cet echantillon se situe dans la plage la plus reguliere, avec un rythme plus stable, une activation contenue et une execution visuelle globalement plus ordonnee.';

  @override
  String get overallDescriptionOrange => 'Profil orange : cet echantillon montre plus de variabilite, une possible sensibilite a la pression situationnelle et des fluctuations du rythme a contextualiser avec d\'autres observations.';

  @override
  String get overallDescriptionRed => 'Profil rouge : cet echantillon montre une charge graphique plus elevee ou une discontinuite marquee. Ces marqueurs peuvent accompagner tension, fatigue ou execution instable, mais ne constituent pas un diagnostic.';

  @override
  String quickSummaryCompact(Object state, Object baseline, Object slant) {
    return '$state Tendance de baseline : $baseline. Style relationnel : $slant.';
  }

  @override
  String get quickBaselineUp => 'ascendante';

  @override
  String get quickBaselineDown => 'descendante';

  @override
  String get quickBaselineStable => 'stable';

  @override
  String get quickSlantRight => 'plus ouvert';

  @override
  String get quickSlantLeft => 'plus reserve';

  @override
  String get quickSlantNeutral => 'equilibre';

  @override
  String detailedSpacingNarrative(Object value, Object tendency) {
    return 'Le ratio d\'espacement $value suggere $tendency.';
  }

  @override
  String get detailedSpacingAutonomy => 'une tendance plus forte a l\'autonomie';

  @override
  String get detailedSpacingCloseness => 'une tendance plus forte a la proximite relationnelle';

  @override
  String detailedSizeNarrative(Object value, Object tendency) {
    return 'La variance de taille $value suggere $tendency.';
  }

  @override
  String get detailedSizeFluctuating => 'une constance attentionnelle fluctuante';

  @override
  String get detailedSizeStable => 'un rythme attentionnel stable';

  @override
  String detailedPenLiftNarrative(Object value, Object tendency) {
    return 'La frequence des leves de stylo $value suggere $tendency.';
  }

  @override
  String get detailedPenLiftSegmented => 'une sequenciation cognitive segmentee';

  @override
  String get detailedPenLiftFluid => 'une continuite cognitive fluide';

  @override
  String psychologicalSnapshot(Object baseline, Object slant, Object pressure, Object spacing, Object rhythm) {
    return 'Lecture psychologique prudente : baseline $baseline, inclinaison $slant, la pression suggere $pressure, l\'espacement est compatible avec $spacing, et le rythme d\'ecriture se rapproche de $rhythm.';
  }

  @override
  String get psychPressureHigh => 'une activation interne plus elevee';

  @override
  String get psychPressureBalanced => 'une modulation tonique assez equilibree';

  @override
  String get psychPressureLow => 'une activation contenue ou un trait plus leger';

  @override
  String get confidenceAdviceHigh => 'La fiabilite est bonne pour une lecture exploratoire, mais l\'image reste seulement un indice visuel.';

  @override
  String get confidenceAdviceMedium => 'La fiabilite est moyenne : utilisez le resultat comme piste, pas comme conclusion.';

  @override
  String get confidenceAdviceLow => 'La fiabilite est faible : refaites la photo et comparez plusieurs echantillons avant interpretation.';

  @override
  String get wellbeingSuggestionTitle => 'Suggestion bien-etre';

  @override
  String get wellbeingSuggestionGreen => 'Si l\'echantillon semble coherent, protegez cet equilibre avec des routines simples : sommeil regulier, pauses courtes et ecriture plus lente sans precipitations.';

  @override
  String get wellbeingSuggestionOrange => 'Si la tension revient souvent, essayez des pauses courtes, une respiration plus lente, moins de precipitations et quelques lignes de journaling pour decharger la charge.';

  @override
  String get wellbeingSuggestionRed => 'Si ces signes se repetent sur plusieurs echantillons ou avec une detresse reelle, reduisez la surcharge, protegez sommeil et pauses, et envisagez d\'en parler a un professionnel qualifie.';

  @override
  String get detailedInterpretationNote => 'Note d\'interpretation : les marqueurs graphomoteurs peuvent decrire la qualite du geste, mais la graphologie de personnalite manque d\'une validation robuste ; cette lecture reste exploratoire et non diagnostique.';

  @override
  String get psychCuesTitle => 'Indices psychologiques exploratoires';

  @override
  String get psychCuesBody => 'Ce sont des etiquettes d\'orientation derivees de la pression, de la regularite et du rythme du geste. Elles rendent le profil plus psychologique, sans definir la personne de facon definitive.';

  @override
  String get psychCueSerenity => 'Serenite';

  @override
  String get psychCueSerenityDetail => 'Le geste parait bien regule, avec une charge contenue et une continuite assez ordonnee.';

  @override
  String get psychCueActivation => 'Activation';

  @override
  String get psychCueActivationDetail => 'L\'energie est presente sans etre extreme ; l\'echantillon doit etre lu selon le contexte et le moment.';

  @override
  String get psychCueStress => 'Stress';

  @override
  String get psychCueStressDetail => 'Une pression ou une fragmentation plus elevee peut accompagner tension et surcharge situationnelle.';

  @override
  String get psychCueStability => 'Stabilite';

  @override
  String get psychCueStabilityDetail => 'La ligne et les proportions restent assez coherentes, ce qui suggere un geste plus stable.';

  @override
  String get psychCueSensitivity => 'Sensibilite';

  @override
  String get psychCueSensitivityDetail => 'De petites oscillations du geste peuvent refleter une reactivite au contexte ou une variabilite du moment.';

  @override
  String get psychCueDiscontinuity => 'Discontinuite';

  @override
  String get psychCueDiscontinuityDetail => 'Des ecarts plus marques du geste peuvent indiquer un echantillon moins regulier.';

  @override
  String get psychCueFluidity => 'Fluidite';

  @override
  String get psychCueFluidityDetail => 'La sequence d\'ecriture parait assez continue et peu coupee.';

  @override
  String get psychCueVariability => 'Variabilite';

  @override
  String get psychCueVariabilityDetail => 'Le rythme alterne entre des passages plus continus et d\'autres plus controles ou segmentes.';

  @override
  String get psychCueFragmentation => 'Fragmentation';

  @override
  String get psychCueFragmentationDetail => 'Le rythme parait plus interrompu ou casse, avec une continuite motrice plus faible.';

  @override
  String get metricBaselineName => 'Angle de baseline';

  @override
  String get metricBaselineExplanation => 'Mesure la stabilite de ligne et la derive directionnelle de l\'echantillon.';

  @override
  String get metricBaselineRule => 'Regle signal: Vert <= 4.0°, Orange <= 8.1°, Rouge > 8.1°.';

  @override
  String get metricSlantName => 'Angle d\'inclinaison';

  @override
  String get metricSlantExplanation => 'Capte l\'ouverture emotionnelle versus un style de communication plus defensif.';

  @override
  String get metricSlantRule => 'Regle signal: Vert <= 11.3°, Orange <= 18.0°, Rouge > 18.0°.';

  @override
  String get metricPressureName => 'Indice de pression';

  @override
  String get metricPressureExplanation => 'Estime la force expressive via densite et obscurite du trait.';

  @override
  String get metricPressureRule => 'Regle signal: Vert 0.38-0.68, Orange 0.28-0.78, Rouge hors plage.';

  @override
  String get metricSpacingName => 'Ratio d\'espacement';

  @override
  String get metricSpacingExplanation => 'Mesure l\'equilibre moyen des espaces entre groupes de traits.';

  @override
  String get metricSpacingRule => 'Regle signal: Vert 0.89-1.48, Orange 0.66-1.82, Rouge hors plage.';

  @override
  String get metricSizeVarianceName => 'Variance de taille';

  @override
  String get metricSizeVarianceExplanation => 'Reflete la coherence de hauteur des lettres et du rythme visuel.';

  @override
  String get metricSizeVarianceRule => 'Regle signal: Vert <= 0.38, Orange <= 0.59, Rouge > 0.59.';

  @override
  String get metricPenLiftsName => 'Leves de stylo';

  @override
  String get metricPenLiftsExplanation => 'Approxime le caractere segmente ou continu de la sequence motrice.';

  @override
  String get metricPenLiftsRule => 'Regle signal: Vert <= 0.41, Orange <= 0.63, Rouge > 0.63.';

  @override
  String get qualityGateTitle => 'Controle qualite de capture';

  @override
  String get qualityGateBody => 'Certaines conditions de capture reduisent la fiabilite. Ameliorez la photo avant d\'interpreter les details.';

  @override
  String qualityGateScoreLine(Object percent) {
    return 'Qualite de capture: $percent%';
  }

  @override
  String get qualityHintCoverageLow => 'La zone d\'ecriture est trop petite dans le cadrage.';

  @override
  String get qualityHintContrastLow => 'Contraste faible: augmentez la lumiere et evitez les ombres.';

  @override
  String get qualityHintSharpnessLow => 'Image peu nette: stabilisez la camera et refaites la mise au point.';

  @override
  String get qualityHintGeneric => 'Un ou plusieurs facteurs qualite sont sous le niveau optimal.';

  @override
  String get qualityRetakeHint => 'Conseil: reprenez de plus pres avec lumiere uniforme et sans reflets.';

  @override
  String get scienceRefsTitle => 'References scientifiques';

  @override
  String get scienceRefsDisclaimer => 'Sources primaires sur trois plans : limites de la graphologie de personnalite, marqueurs graphomoteurs dans des contextes motrices-cognitifs et benefices modestes possibles de l\'ecriture expressive. Elles ne valident ni diagnostic ni profil psychologique individuel a partir d\'un seul echantillon.';

  @override
  String get openSource => 'Ouvrir la source';

  @override
  String get freeProTeaserTitle => 'Vous voulez l\'analyse detaillee complete ?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Debloquez Pro pour obtenir une lecture exploratoire plus detaillee, tous les marqueurs quantitatifs et un resultat sans pub pour $price.';
  }

  @override
  String get freeProTeaserButton => 'Voir l\'offre Pro';

  @override
  String proMoreIndicatorsHint(Object count) {
    return 'Fonctions Pro : debloquez $count indicateurs supplementaires et l\'analyse detaillee complete.';
  }

  @override
  String get errorUnsupportedImageFormat => 'Format d\'image non pris en charge.';

  @override
  String get errorImageTooSmall => 'Image trop petite. Prenez une photo plus proche et plus nette.';

  @override
  String get errorNotEnoughHandwriting => 'Ecriture insuffisante detectee. Reessayez avec un meilleur cadrage.';

  @override
  String get errorHandwritingRequired => 'Photographiez un texte ecrit a la main. Reessayez.';

  @override
  String get tabFree => 'Gratuit';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Partager';

  @override
  String get legendTitle => 'Legende psychologique du feu tricolore';

  @override
  String get legendBody => 'Vert : motif plus regulier et moins charge.\nOrange : variabilite et tension a contextualiser.\nRouge : plus grande discontinuite ou charge graphique ; pas un diagnostic.';

  @override
  String get unlockFullPsychProfile => 'Debloquer la lecture detaillee';

  @override
  String get unlockFullPsychProfileBody => 'Vous avez deja termine l\'analyse. Debloquez une lecture exploratoire plus detaillee, la signification du feu tricolore et tous les marqueurs quantitatifs.';

  @override
  String get valuePsychReport => 'Rapport exploratoire detaille';

  @override
  String get valueRiskMarkers => 'Marqueurs de risque potentiels';

  @override
  String get valueNoAdsThisResult => 'Sans publicites pour ce resultat';

  @override
  String get processing => 'Traitement...';

  @override
  String unlockProForPrice(Object price) {
    return 'Debloquer Pro pour $price';
  }

  @override
  String get storeSetupPending => 'Configuration du produit boutique en attente.';

  @override
  String get sharePanelText => 'Partagez sur WhatsApp, Telegram, TikTok, Instagram, Facebook ou via le partage systeme.';

  @override
  String get openPrivacyDisclaimer => 'Ouvrir confidentialite et avertissement';

  @override
  String get policyTitle => 'Confidentialite et Avertissement';

  @override
  String get policyBody => 'Mise a jour : 4 mars 2026\n\n1) Finalite et base legale\nUsage educatif uniquement. Le traitement repose sur le consentement explicite (RGPD Art. 6(1)(a) et, si applicable, Art. 9(2)(a)).\n\n2) Minimisation des donnees\nCamera en direct uniquement. Pas de galerie ni de fichier. Les photos temporaires sont supprimees dans la mesure du possible. Les principes de minimisation et de limitation de finalite sont appliques (RGPD Art. 5 et Art. 25).\n\n3) Limites du profilage\nN\'utilisez pas cette application pour des decisions d\'embauche, de credit, d\'assurance, juridiques ou a fort impact. Aucune decision ne doit etre prise uniquement sur cette sortie automatisee (RGPD Art. 22).\n\n4) Traitement par des tiers\nLe mode gratuit utilise des SDK publicitaires. Le debloquage Pro utilise la facturation du store. Les fournisseurs peuvent traiter des identifiants appareil/transaction.\n\n5) Transparence\nLes utilisateurs sont informes qu\'ils interagissent avec du contenu genere par IA (AI Act Art. 50, principe de transparence).\n\n6) Limites d\'usage interdit\nL\'application ne doit pas etre utilisee a des fins manipulatoires ou nuisibles de type social scoring (AI Act Art. 5, pratiques interdites).\n\n7) Droits des utilisateurs\nLes utilisateurs peuvent retirer leur consentement a tout moment depuis ce panneau. Les obligations d\'information et les droits doivent figurer dans l\'avis de confidentialite du store (RGPD Art. 13 et Arts. 15-17).\n\n8) Avertissement medical\nAucun diagnostic medical ou clinique n\'est fourni. Un resultat rouge indique des marqueurs de risque potentiels, pas un trouble confirme.\n\n9) Note de conformite\nCe texte in-app ne constitue pas un conseil juridique. Effectuez une revision juridique complete avant publication.';

  @override
  String get withdrawConsent => 'Retirer le consentement';

  @override
  String get keepDisabled => 'Laisser desactive';

  @override
  String get accept => 'Accepter';

  @override
  String get signalBalance => 'Equilibre';

  @override
  String get signalVulnerability => 'Vulnerabilite';

  @override
  String get signalPotentialPathology => 'Charge elevee';

  @override
  String get overallGreenTitle => 'PROFIL VERT - Echantillon plus regulier';

  @override
  String get overallOrangeTitle => 'PROFIL ORANGE - Variabilite et tension';

  @override
  String get overallRedTitle => 'PROFIL ROUGE - Charge ou discontinuite';

  @override
  String get proUnlockedFullDataAvailable => 'Pro debloque. Donnees completes disponibles.';

  @override
  String get storeProductUnavailableNow => 'Produit boutique indisponible.';

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
  String get moreLabel => 'Plus';
}
