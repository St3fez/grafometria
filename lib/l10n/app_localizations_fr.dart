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
  String get overallSummaryGreen => 'Profil general : personnalite centree, serenite emotionnelle et bonne autoregulation.';

  @override
  String get overallSummaryOrange => 'Profil general : personnalite sensible avec tension interne et fluctuations emotionnelles.';

  @override
  String get overallSummaryRed => 'Profil general : des signaux de dysregulation emotionnelle marquee et de traits psychologiques a haut risque emergent.';

  @override
  String get overallDescriptionGreen => 'Profil vert : les traits suggerent une stabilite affective, un controle des impulsions equilibre et une adaptation efficace au stress quotidien.';

  @override
  String get overallDescriptionOrange => 'Profil orange : les traits suggerent une forte sensibilite, une charge interne accrue et une vulnerabilite sous pression ; la reactivite relationnelle peut augmenter en phase de stress.';

  @override
  String get overallDescriptionRed => 'Profil rouge : les traits suggerent des patterns persistants de souffrance psychologique, une possible dysregulation affective et des marqueurs potentiellement pathologiques. Si ce profil se repete, recherchez une evaluation professionnelle.';

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
  String get detailedInterpretationNote => 'Note d\'interpretation : cette lecture est un screening psychologique et ne constitue pas un diagnostic medical ou psychiatrique.';

  @override
  String get metricBaselineName => 'Angle de baseline';

  @override
  String get metricBaselineExplanation => 'Mesure la stabilite de ligne et la derive directionnelle de l\'echantillon.';

  @override
  String get metricBaselineRule => 'Regle signal: Vert <= 4.5°, Orange <= 9°, Rouge > 9°.';

  @override
  String get metricSlantName => 'Angle d\'inclinaison';

  @override
  String get metricSlantExplanation => 'Capte l\'ouverture emotionnelle versus un style de communication plus defensif.';

  @override
  String get metricSlantRule => 'Regle signal: Vert <= 12.5°, Orange <= 20°, Rouge > 20°.';

  @override
  String get metricPressureName => 'Indice de pression';

  @override
  String get metricPressureExplanation => 'Estime la force expressive via densite et obscurite du trait.';

  @override
  String get metricPressureRule => 'Regle signal: Vert 0.34-0.72, Orange 0.24-0.82, Rouge hors plage.';

  @override
  String get metricSpacingName => 'Ratio d\'espacement';

  @override
  String get metricSpacingExplanation => 'Mesure l\'equilibre moyen des espaces entre groupes de traits.';

  @override
  String get metricSpacingRule => 'Regle signal: Vert 0.82-1.55, Orange 0.60-1.95, Rouge hors plage.';

  @override
  String get metricSizeVarianceName => 'Variance de taille';

  @override
  String get metricSizeVarianceExplanation => 'Reflete la coherence de hauteur des lettres et du rythme visuel.';

  @override
  String get metricSizeVarianceRule => 'Regle signal: Vert <= 0.42, Orange <= 0.66, Rouge > 0.66.';

  @override
  String get metricPenLiftsName => 'Leves de stylo';

  @override
  String get metricPenLiftsExplanation => 'Approxime le caractere segmente ou continu de la sequence motrice.';

  @override
  String get metricPenLiftsRule => 'Regle signal: Vert <= 0.46, Orange <= 0.70, Rouge > 0.70.';

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
  String get scienceRefsDisclaimer => 'References a but informatif. L\'app ne fournit pas de diagnostic.';

  @override
  String get openSource => 'Ouvrir la source';

  @override
  String get freeProTeaserTitle => 'Vous voulez l\'analyse detaillee complete ?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Debloquez Pro pour obtenir le profil psychologique complet, tous les marqueurs quantitatifs et un resultat sans pub pour $price.';
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
  String get tabFree => 'Gratuit';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Partager';

  @override
  String get legendTitle => 'Legende psychologique du feu tricolore';

  @override
  String get legendBody => 'Vert : equilibre et serenite.\nOrange : tension emotionnelle/vulnerabilite.\nRouge : traits potentiellement pathologiques (signal de depistage).';

  @override
  String get unlockFullPsychProfile => 'Debloquer le profil psychologique complet';

  @override
  String get unlockFullPsychProfileBody => 'Vous avez deja termine l\'analyse. Debloquez l\'interpretation psychologique complete, la signification du feu tricolore et tous les marqueurs quantitatifs.';

  @override
  String get valuePsychReport => 'Rapport psychologique complet';

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
  String get signalPotentialPathology => 'Pathologie potentielle';

  @override
  String get overallGreenTitle => 'PROFIL VERT - Equilibre et serenite';

  @override
  String get overallOrangeTitle => 'PROFIL ORANGE - Tension emotionnelle et fragilite';

  @override
  String get overallRedTitle => 'PROFIL ROUGE - Traits potentiellement pathologiques';

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
