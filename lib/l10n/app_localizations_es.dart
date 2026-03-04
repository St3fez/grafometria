// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'HandwritingAnalysis';

  @override
  String get languageTooltip => 'Idioma';

  @override
  String get languageSystemDefault => 'Predeterminado del sistema';

  @override
  String get privacyTooltip => 'Privacidad y aviso legal';

  @override
  String get loadingPrivacySettings => 'Cargando ajustes de privacidad...';

  @override
  String get tickConsentBeforeContinuing => 'Marca el consentimiento antes de continuar.';

  @override
  String get consentSavedCameraEnabled => 'Consentimiento guardado. Captura con camara activada.';

  @override
  String get analyzingPreparingResultPopup => 'Analizando la escritura y preparando la ventana de resultado...';

  @override
  String freeModeSummary(Object price) {
    return 'Modo gratis: perfil basico con anuncios. Modo Pro: informe completo por $price.';
  }

  @override
  String get headerSubtitle => 'Analisis con camara en vivo. Resultado en ventana moderna con indicadores tipo semaforo.';

  @override
  String get captureLivePhoto => 'Capturar foto en vivo';

  @override
  String get trustLiveCameraOnly => 'Solo camara en vivo';

  @override
  String get trustNoGalleryOrFile => 'Sin galeria ni carga de archivos';

  @override
  String get trustTemporaryCleanup => 'Limpieza temporal de fotos';

  @override
  String get consentRequiredTitle => 'Se requiere consentimiento de privacidad y aviso legal';

  @override
  String get consentRequiredBody => 'Revisa privacidad/aviso legal antes del primer analisis. La app es educativa y no diagnostica.';

  @override
  String get consentCheckbox => 'He leido y acepto la politica.';

  @override
  String get readPolicy => 'Leer politica';

  @override
  String get acceptAndContinue => 'Aceptar y continuar';

  @override
  String get noCaptureYet => 'Aun no hay captura. Usa la camara en vivo.';

  @override
  String get resultPopupReadyTitle => 'Tu ventana de resultado esta lista';

  @override
  String get proPopupReadyTitle => 'Tu informe Pro en ventana esta listo';

  @override
  String get resultPopupBody => 'Abre la ventana con pestañas de Gratis, Pro y Compartir.';

  @override
  String get openResultPopup => 'Abrir resultado';

  @override
  String get share => 'Compartir';

  @override
  String get purchaseStreamError => 'Error del flujo de compra.';

  @override
  String storeProductUnavailable(Object productId) {
    return 'Producto de tienda no disponible. Configura primero \"$productId\".';
  }

  @override
  String get openingSecureCheckout => 'Abriendo pago seguro...';

  @override
  String get proReportUnlocked => 'Informe Pro desbloqueado.';

  @override
  String get purchaseFailed => 'La compra fallo.';

  @override
  String get purchaseCanceled => 'Compra cancelada.';

  @override
  String get privacyAccepted => 'Privacidad y aviso legal aceptados.';

  @override
  String get consentWithdrawn => 'Consentimiento retirado. Captura desactivada.';

  @override
  String get shareMyResult => 'Mi resultado de HandwritingAnalysis:';

  @override
  String shareConfidenceLine(Object label, Object percent) {
    return 'Confianza: $label ($percent%)';
  }

  @override
  String get shareDetailedMetricsHeader => 'Metricas detalladas:';

  @override
  String get shareProHint => 'El desbloqueo Pro muestra todos los detalles cuantitativos.';

  @override
  String get shareTryApp => 'Prueba HandwritingAnalysis.';

  @override
  String get graphometryResult => 'Resultado HandwritingAnalysis';

  @override
  String reliabilityLine(Object label, Object percent) {
    return 'Fiabilidad: $label ($percent%)';
  }

  @override
  String get confidenceHigh => 'Alta';

  @override
  String get confidenceMedium => 'Media';

  @override
  String get confidenceLow => 'Baja';

  @override
  String photoQualityShortLine(Object percent) {
    return 'Calidad foto: $percent%';
  }

  @override
  String get overallSummaryGreen => 'Perfil general: personalidad centrada, serenidad emocional y buena autorregulacion.';

  @override
  String get overallSummaryOrange => 'Perfil general: personalidad sensible con tension interna y oscilaciones emocionales.';

  @override
  String get overallSummaryRed => 'Perfil general: emergen senales de marcada desregulacion emocional y rasgos psicologicos de alto riesgo.';

  @override
  String get overallDescriptionGreen => 'Perfil verde: los rasgos sugieren estabilidad afectiva, control de impulsos equilibrado y afrontamiento adaptativo ante el estres cotidiano.';

  @override
  String get overallDescriptionOrange => 'Perfil naranja: los rasgos sugieren alta sensibilidad, mayor carga interna y vulnerabilidad bajo presion; en fases de estres puede aumentar la reactividad relacional.';

  @override
  String get overallDescriptionRed => 'Perfil rojo: los rasgos sugieren patrones persistentes de malestar psicologico, posible desregulacion afectiva y marcadores potencialmente patologicos. Si este patron se repite, busca evaluacion profesional.';

  @override
  String quickSummaryCompact(Object state, Object baseline, Object slant) {
    return '$state Tendencia de baseline: $baseline. Estilo relacional: $slant.';
  }

  @override
  String get quickBaselineUp => 'ascendente';

  @override
  String get quickBaselineDown => 'descendente';

  @override
  String get quickBaselineStable => 'estable';

  @override
  String get quickSlantRight => 'mas abierto';

  @override
  String get quickSlantLeft => 'mas reservado';

  @override
  String get quickSlantNeutral => 'equilibrado';

  @override
  String detailedSpacingNarrative(Object value, Object tendency) {
    return 'La proporcion de espaciado $value sugiere $tendency.';
  }

  @override
  String get detailedSpacingAutonomy => 'una tendencia mas fuerte a la autonomia';

  @override
  String get detailedSpacingCloseness => 'una tendencia mas fuerte a la cercania relacional';

  @override
  String detailedSizeNarrative(Object value, Object tendency) {
    return 'La variacion de tamano $value sugiere $tendency.';
  }

  @override
  String get detailedSizeFluctuating => 'consistencia atencional fluctuante';

  @override
  String get detailedSizeStable => 'ritmo atencional estable';

  @override
  String detailedPenLiftNarrative(Object value, Object tendency) {
    return 'La frecuencia de levantamientos de lapiz $value sugiere $tendency.';
  }

  @override
  String get detailedPenLiftSegmented => 'secuenciacion cognitiva segmentada';

  @override
  String get detailedPenLiftFluid => 'continuidad cognitiva fluida';

  @override
  String get detailedInterpretationNote => 'Nota: esta lectura es de cribado psicologico y no constituye diagnostico medico o psiquiatrico.';

  @override
  String get metricBaselineName => 'Angulo baseline';

  @override
  String get metricBaselineExplanation => 'Sigue estabilidad de linea y deriva direccional en la muestra.';

  @override
  String get metricBaselineRule => 'Regla de senal: Verde <= 4.5°, Naranja <= 9°, Rojo > 9°.';

  @override
  String get metricSlantName => 'Angulo de inclinacion';

  @override
  String get metricSlantExplanation => 'Captura apertura emocional frente a estilo comunicativo defensivo.';

  @override
  String get metricSlantRule => 'Regla de senal: Verde <= 12.5°, Naranja <= 20°, Rojo > 20°.';

  @override
  String get metricPressureName => 'Indice de presion';

  @override
  String get metricPressureExplanation => 'Estima fuerza expresiva por densidad y oscuridad del trazo.';

  @override
  String get metricPressureRule => 'Regla de senal: Verde 0.34-0.72, Naranja 0.24-0.82, Rojo fuera de rango.';

  @override
  String get metricSpacingName => 'Proporcion de espaciado';

  @override
  String get metricSpacingExplanation => 'Mide el equilibrio medio de espacios entre grupos de trazos.';

  @override
  String get metricSpacingRule => 'Regla de senal: Verde 0.82-1.55, Naranja 0.60-1.95, Rojo fuera de rango.';

  @override
  String get metricSizeVarianceName => 'Variacion de tamano';

  @override
  String get metricSizeVarianceExplanation => 'Refleja consistencia de altura de letras y ritmo visual.';

  @override
  String get metricSizeVarianceRule => 'Regla de senal: Verde <= 0.42, Naranja <= 0.66, Rojo > 0.66.';

  @override
  String get metricPenLiftsName => 'Levantamientos de lapiz';

  @override
  String get metricPenLiftsExplanation => 'Aproxima cuan segmentada o continua parece la secuencia motora.';

  @override
  String get metricPenLiftsRule => 'Regla de senal: Verde <= 0.46, Naranja <= 0.70, Rojo > 0.70.';

  @override
  String get qualityGateTitle => 'Control de calidad de captura';

  @override
  String get qualityGateBody => 'Algunas condiciones de captura reducen la fiabilidad. Mejora la foto antes de confiar en los detalles.';

  @override
  String qualityGateScoreLine(Object percent) {
    return 'Calidad de captura: $percent%';
  }

  @override
  String get qualityHintCoverageLow => 'El area de escritura es demasiado pequena en el encuadre.';

  @override
  String get qualityHintContrastLow => 'Contraste bajo: aumenta la luz y evita sombras.';

  @override
  String get qualityHintSharpnessLow => 'La imagen se ve suave: manten la camara estable y reenfoca.';

  @override
  String get qualityHintGeneric => 'Uno o mas factores de calidad estan por debajo del nivel optimo.';

  @override
  String get qualityRetakeHint => 'Consejo: repite la foto mas cerca, con luz uniforme y sin reflejos.';

  @override
  String get scienceRefsTitle => 'Referencias cientificas';

  @override
  String get scienceRefsDisclaimer => 'Referencias divulgativas. La app no proporciona diagnostico.';

  @override
  String get openSource => 'Abrir fuente';

  @override
  String get freeProTeaserTitle => 'Quieres el analisis detallado completo?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Desbloquea Pro para obtener perfil psicologico completo, todos los marcadores cuantitativos y resultado sin anuncios por $price.';
  }

  @override
  String get freeProTeaserButton => 'Ver oferta Pro';

  @override
  String proMoreIndicatorsHint(Object count) {
    return 'Funciones Pro: desbloquea $count indicadores adicionales y analisis detallado completo.';
  }

  @override
  String get errorUnsupportedImageFormat => 'Formato de imagen no compatible.';

  @override
  String get errorImageTooSmall => 'Imagen demasiado pequena. Captura una foto mas cercana y nitida.';

  @override
  String get errorNotEnoughHandwriting => 'No se detecta suficiente escritura. Prueba con mejor encuadre.';

  @override
  String get tabFree => 'Gratis';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Compartir';

  @override
  String get legendTitle => 'Leyenda psicologica del semaforo';

  @override
  String get legendBody => 'Verde: equilibrio y serenidad.\nNaranja: tension emocional/vulnerabilidad.\nRojo: rasgos potencialmente patologicos (senal de cribado).';

  @override
  String get unlockFullPsychProfile => 'Desbloquea el perfil psicologico completo';

  @override
  String get unlockFullPsychProfileBody => 'Ya completaste el analisis. Desbloquea la interpretacion psicologica completa, el significado del semaforo y todos los marcadores cuantitativos.';

  @override
  String get valuePsychReport => 'Informe psicologico completo';

  @override
  String get valueRiskMarkers => 'Marcadores de riesgo potencial';

  @override
  String get valueNoAdsThisResult => 'Sin anuncios en este resultado';

  @override
  String get processing => 'Procesando...';

  @override
  String unlockProForPrice(Object price) {
    return 'Desbloquear Pro por $price';
  }

  @override
  String get storeSetupPending => 'Configuracion del producto en tienda pendiente.';

  @override
  String get sharePanelText => 'Comparte en WhatsApp, Telegram, TikTok, Instagram, Facebook o compartir del sistema.';

  @override
  String get openPrivacyDisclaimer => 'Abrir privacidad y aviso legal';

  @override
  String get policyTitle => 'Privacidad y Aviso Legal';

  @override
  String get policyBody => 'Actualizado: 4 de marzo de 2026\n\n1) Finalidad y base legal\nUso solo educativo. El tratamiento se basa en consentimiento explicito (RGPD Art. 6(1)(a) y, cuando corresponda, Art. 9(2)(a)).\n\n2) Minimizacion de datos\nSolo camara en vivo. Sin galeria ni carga de archivos. Las fotos temporales se eliminan en la medida de lo posible. Se aplican minimizacion y limitacion de finalidad (RGPD Art. 5 y Art. 25).\n\n3) Limites de perfilado\nNo uses esta app para decisiones de empleo, credito, seguros, legales o de alto impacto. No debe tomarse ninguna decision solo con esta salida automatizada (RGPD Art. 22).\n\n4) Tratamiento por terceros\nEl modo gratis usa SDK de anuncios. El desbloqueo Pro usa facturacion de la tienda. Los proveedores pueden tratar identificadores de dispositivo/transaccion.\n\n5) Transparencia\nSe informa a los usuarios de que interactuan con contenido generado por IA (AI Act Art. 50, principio de transparencia).\n\n6) Limites de uso prohibido\nLa app no debe usarse para usos manipulativos o daninos tipo puntuacion social (AI Act Art. 5, practicas prohibidas).\n\n7) Derechos del usuario\nLos usuarios pueden retirar el consentimiento en cualquier momento desde este panel. Los deberes de informacion y derechos deben reflejarse en el aviso de privacidad de la tienda (RGPD Art. 13 y Arts. 15-17).\n\n8) Aviso medico\nNo se proporciona diagnostico medico ni clinico. Un resultado rojo indica posibles marcadores de riesgo, no un trastorno confirmado.\n\n9) Nota de cumplimiento\nEste texto dentro de la app no es asesoramiento legal. Realiza una revision legal completa antes de la publicacion.';

  @override
  String get withdrawConsent => 'Retirar consentimiento';

  @override
  String get keepDisabled => 'Mantener desactivado';

  @override
  String get accept => 'Aceptar';

  @override
  String get signalBalance => 'Equilibrio';

  @override
  String get signalVulnerability => 'Vulnerabilidad';

  @override
  String get signalPotentialPathology => 'Patologia potencial';

  @override
  String get overallGreenTitle => 'PERFIL VERDE - Equilibrio y serenidad';

  @override
  String get overallOrangeTitle => 'PERFIL NARANJA - Tension emocional y fragilidad';

  @override
  String get overallRedTitle => 'PERFIL ROJO - Rasgos potencialmente patologicos';

  @override
  String get proUnlockedFullDataAvailable => 'Pro desbloqueado. Datos completos disponibles.';

  @override
  String get storeProductUnavailableNow => 'Producto de tienda no disponible.';

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
  String get moreLabel => 'Mas';
}
