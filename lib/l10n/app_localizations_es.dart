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
  String get overallSummaryGreen => 'Muestra regular: patron grafico equilibrado y sin marcadores fuertes de carga.';

  @override
  String get overallSummaryOrange => 'Muestra variable: sensibilidad al estres y tension para leer con cautela.';

  @override
  String get overallSummaryRed => 'Muestra mas cargada o discontinua: posibles marcadores de fatiga y tension.';

  @override
  String get overallDescriptionGreen => 'Perfil verde: esta muestra cae en el rango mas regular, con ritmo mas estable, activacion contenida y una ejecucion visual mas ordenada en conjunto.';

  @override
  String get overallDescriptionOrange => 'Perfil naranja: esta muestra presenta mas variabilidad, posible sensibilidad a la presion situacional y fluctuaciones del ritmo que deben contextualizarse con otras observaciones.';

  @override
  String get overallDescriptionRed => 'Perfil rojo: esta muestra presenta mayor carga grafica o discontinuidad marcada. Estos marcadores pueden acompanar tension, fatiga o ejecucion inestable, pero no son un diagnostico.';

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
  String psychologicalSnapshot(Object baseline, Object slant, Object pressure, Object spacing, Object rhythm) {
    return 'Lectura psicologica prudente: baseline $baseline, inclinacion $slant, la presion sugiere $pressure, el espaciado es compatible con $spacing y el ritmo de escritura se parece mas a $rhythm.';
  }

  @override
  String get psychPressureHigh => 'mayor activacion interna';

  @override
  String get psychPressureBalanced => 'modulacion tonica bastante equilibrada';

  @override
  String get psychPressureLow => 'activacion contenida o trazo mas ligero';

  @override
  String get confidenceAdviceHigh => 'La fiabilidad es buena para una lectura exploratoria, pero la imagen sigue siendo solo una pista visual.';

  @override
  String get confidenceAdviceMedium => 'La fiabilidad es media: usa el resultado como pista, no como conclusion.';

  @override
  String get confidenceAdviceLow => 'La fiabilidad es baja: repite la foto y compara varias muestras antes de interpretarla.';

  @override
  String get wellbeingSuggestionTitle => 'Sugerencia de bienestar';

  @override
  String get wellbeingSuggestionGreen => 'Si la muestra parece coherente, protege ese equilibrio con rutinas simples: sueno regular, pausas breves y escritura mas lenta sin prisa.';

  @override
  String get wellbeingSuggestionOrange => 'Si la tension es recurrente, prueba pausas cortas, respiracion mas lenta, menos prisa y unas lineas de journaling para descargar carga.';

  @override
  String get wellbeingSuggestionRed => 'Si estas senales se repiten en varias muestras o junto con malestar real, reduce sobrecarga, protege sueno y pausas y considera hablar con un profesional cualificado.';

  @override
  String get detailedInterpretationNote => 'Nota de interpretacion: los marcadores grafomotores pueden describir la calidad del gesto, pero la grafologia de personalidad carece de validacion robusta; esta lectura sigue siendo exploratoria y no diagnostica.';

  @override
  String get psychCuesTitle => 'Claves psicologicas exploratorias';

  @override
  String get psychCuesBody => 'Son etiquetas orientativas derivadas de la presion, la regularidad y el ritmo del gesto. Hacen el perfil mas psicologico, pero no definen a la persona de forma definitiva.';

  @override
  String get psychCueSerenity => 'Serenidad';

  @override
  String get psychCueSerenityDetail => 'El gesto parece bien regulado, con carga contenida y una continuidad bastante ordenada.';

  @override
  String get psychCueActivation => 'Activacion';

  @override
  String get psychCueActivationDetail => 'Hay energia presente pero no extrema; la muestra debe leerse a la luz del contexto y del momento.';

  @override
  String get psychCueStress => 'Estres';

  @override
  String get psychCueStressDetail => 'Una presion o fragmentacion mas altas pueden acompanar tension y sobrecarga situacional.';

  @override
  String get psychCueStability => 'Estabilidad';

  @override
  String get psychCueStabilityDetail => 'La linea y las proporciones se mantienen bastante coherentes, lo que sugiere un gesto mas estable.';

  @override
  String get psychCueSensitivity => 'Sensibilidad';

  @override
  String get psychCueSensitivityDetail => 'Pequenas oscilaciones del gesto pueden reflejar reactividad al contexto o variabilidad del momento.';

  @override
  String get psychCueDiscontinuity => 'Discontinuidad';

  @override
  String get psychCueDiscontinuityDetail => 'Cambios marcados del gesto pueden indicar un patron de muestra menos regular.';

  @override
  String get psychCueFluidity => 'Fluidez';

  @override
  String get psychCueFluidityDetail => 'La secuencia de escritura parece bastante continua y poco interrumpida.';

  @override
  String get psychCueVariability => 'Variabilidad';

  @override
  String get psychCueVariabilityDetail => 'El ritmo alterna entre tramos mas continuos y otros mas controlados o segmentados.';

  @override
  String get psychCueFragmentation => 'Fragmentacion';

  @override
  String get psychCueFragmentationDetail => 'El ritmo parece mas interrumpido o roto, con menor continuidad motora.';

  @override
  String get metricBaselineName => 'Angulo baseline';

  @override
  String get metricBaselineExplanation => 'Sigue estabilidad de linea y deriva direccional en la muestra.';

  @override
  String get metricBaselineRule => 'Regla de senal: Verde <= 4.0°, Naranja <= 8.1°, Rojo > 8.1°.';

  @override
  String get metricSlantName => 'Angulo de inclinacion';

  @override
  String get metricSlantExplanation => 'Captura apertura emocional frente a estilo comunicativo defensivo.';

  @override
  String get metricSlantRule => 'Regla de senal: Verde <= 11.3°, Naranja <= 18.0°, Rojo > 18.0°.';

  @override
  String get metricPressureName => 'Indice de presion';

  @override
  String get metricPressureExplanation => 'Estima fuerza expresiva por densidad y oscuridad del trazo.';

  @override
  String get metricPressureRule => 'Regla de senal: Verde 0.38-0.68, Naranja 0.28-0.78, Rojo fuera de rango.';

  @override
  String get metricSpacingName => 'Proporcion de espaciado';

  @override
  String get metricSpacingExplanation => 'Mide el equilibrio medio de espacios entre grupos de trazos.';

  @override
  String get metricSpacingRule => 'Regla de senal: Verde 0.89-1.48, Naranja 0.66-1.82, Rojo fuera de rango.';

  @override
  String get metricSizeVarianceName => 'Variacion de tamano';

  @override
  String get metricSizeVarianceExplanation => 'Refleja consistencia de altura de letras y ritmo visual.';

  @override
  String get metricSizeVarianceRule => 'Regla de senal: Verde <= 0.38, Naranja <= 0.59, Rojo > 0.59.';

  @override
  String get metricPenLiftsName => 'Levantamientos de lapiz';

  @override
  String get metricPenLiftsExplanation => 'Aproxima cuan segmentada o continua parece la secuencia motora.';

  @override
  String get metricPenLiftsRule => 'Regla de senal: Verde <= 0.41, Naranja <= 0.63, Rojo > 0.63.';

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
  String get scienceRefsDisclaimer => 'Fuentes primarias en tres planos: limites de la grafologia de personalidad, marcadores grafomotores en contextos motor-cognitivos y posibles beneficios modestos de la escritura expresiva. No validan diagnosticos ni perfiles psicologicos individuales a partir de una sola muestra.';

  @override
  String get openSource => 'Abrir fuente';

  @override
  String get freeProTeaserTitle => 'Quieres el analisis detallado completo?';

  @override
  String freeProTeaserBody(Object price) {
    return 'Desbloquea Pro para obtener una lectura exploratoria mas detallada, todos los marcadores cuantitativos y resultado sin anuncios por $price.';
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
  String get errorHandwritingRequired => 'Fotografia un texto escrito a mano. Vuelve a intentarlo.';

  @override
  String get tabFree => 'Gratis';

  @override
  String get tabPro => 'Pro';

  @override
  String get tabShare => 'Compartir';

  @override
  String get legendTitle => 'Leyenda psicologica del semaforo';

  @override
  String get legendBody => 'Verde: patron mas regular y menos cargado.\nNaranja: variabilidad y tension para contextualizar.\nRojo: mayor discontinuidad o carga grafica; no es diagnostico.';

  @override
  String get unlockFullPsychProfile => 'Desbloquea la lectura detallada';

  @override
  String get unlockFullPsychProfileBody => 'Ya completaste el analisis. Desbloquea una lectura exploratoria mas detallada, el significado del semaforo y todos los marcadores cuantitativos.';

  @override
  String get valuePsychReport => 'Informe exploratorio detallado';

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
  String get signalPotentialPathology => 'Carga alta';

  @override
  String get overallGreenTitle => 'PERFIL VERDE - Muestra mas regular';

  @override
  String get overallOrangeTitle => 'PERFIL NARANJA - Variabilidad y tension';

  @override
  String get overallRedTitle => 'PERFIL ROJO - Carga o discontinuidad';

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
