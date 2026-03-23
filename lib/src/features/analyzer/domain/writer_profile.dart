import 'package:grafometria/l10n/app_localizations.dart';

class WriterProfile {
  const WriterProfile({
    required this.baselineAngle,
    required this.slantAngle,
    required this.pressureIndex,
    required this.spacingRatio,
    required this.letterSizeVariance,
    required this.penLiftFrequency,
    required this.confidenceScore,
    this.contrastIndex = 0.7,
    this.sharpnessIndex = 0.7,
    this.coverageIndex = 0.7,
    this.qualityGateScore = 0.7,
  });

  final double baselineAngle;
  final double slantAngle;
  final double pressureIndex;
  final double spacingRatio;
  final double letterSizeVariance;
  final double penLiftFrequency;
  final double confidenceScore;
  final double contrastIndex;
  final double sharpnessIndex;
  final double coverageIndex;
  final double qualityGateScore;

  factory WriterProfile.fromJson(Map<String, dynamic> json) {
    return WriterProfile(
      baselineAngle: (json['baselineAngle'] as num).toDouble(),
      slantAngle: (json['slantAngle'] as num).toDouble(),
      pressureIndex: (json['pressureIndex'] as num).toDouble(),
      spacingRatio: (json['spacingRatio'] as num).toDouble(),
      letterSizeVariance: (json['letterSizeVariance'] as num).toDouble(),
      penLiftFrequency: (json['penLiftFrequency'] as num).toDouble(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      contrastIndex: ((json['contrastIndex'] as num?)?.toDouble() ?? 0.7).clamp(
        0.0,
        1.0,
      ),
      sharpnessIndex: ((json['sharpnessIndex'] as num?)?.toDouble() ?? 0.7)
          .clamp(0.0, 1.0),
      coverageIndex: ((json['coverageIndex'] as num?)?.toDouble() ?? 0.7).clamp(
        0.0,
        1.0,
      ),
      qualityGateScore: ((json['qualityGateScore'] as num?)?.toDouble() ?? 0.7)
          .clamp(0.0, 1.0),
    );
  }

  bool get qualityGateNeedsAttention {
    return qualityGateScore < 0.64 || confidenceScore < 0.61;
  }

  List<String> qualityGateHints(AppLocalizations l10n) {
    final hints = <String>[];
    if (coverageIndex < 0.51) {
      hints.add(l10n.qualityHintCoverageLow);
    }
    if (contrastIndex < 0.48) {
      hints.add(l10n.qualityHintContrastLow);
    }
    if (sharpnessIndex < 0.48) {
      hints.add(l10n.qualityHintSharpnessLow);
    }
    if (hints.isEmpty && qualityGateNeedsAttention) {
      hints.add(l10n.qualityHintGeneric);
    }
    return hints;
  }

  String confidenceLabel(AppLocalizations l10n) {
    if (confidenceScore >= 0.82) {
      return l10n.confidenceHigh;
    }
    if (confidenceScore >= 0.50) {
      return l10n.confidenceMedium;
    }
    return l10n.confidenceLow;
  }

  String quickSummary(AppLocalizations l10n) {
    return l10n.quickSummaryCompact(
      overallStateSummary(l10n),
      _baselineMeaning(l10n),
      _slantMeaning(l10n),
    );
  }

  String detailedNarrative(AppLocalizations l10n) {
    final details = <String>[];

    details.add(overallStateDescription(l10n));
    details.add(psychologicalSnapshot(l10n));
    details.add(
      l10n.detailedSpacingNarrative(
        spacingRatio.toStringAsFixed(2),
        spacingRatio > 1.25
            ? l10n.detailedSpacingAutonomy
            : l10n.detailedSpacingCloseness,
      ),
    );
    details.add(
      l10n.detailedSizeNarrative(
        letterSizeVariance.toStringAsFixed(2),
        letterSizeVariance > 0.45
            ? l10n.detailedSizeFluctuating
            : l10n.detailedSizeStable,
      ),
    );
    details.add(
      l10n.detailedPenLiftNarrative(
        penLiftFrequency.toStringAsFixed(2),
        penLiftFrequency > 0.55
            ? l10n.detailedPenLiftSegmented
            : l10n.detailedPenLiftFluid,
      ),
    );
    details.add(confidenceAdvice(l10n));
    details.add(l10n.detailedInterpretationNote);

    return details.join(' ');
  }

  String psychologicalSnapshot(AppLocalizations l10n) {
    return l10n.psychologicalSnapshot(
      _baselineMeaning(l10n),
      _slantMeaning(l10n),
      _pressureMeaning(l10n),
      spacingRatio > 1.25
          ? l10n.detailedSpacingAutonomy
          : l10n.detailedSpacingCloseness,
      penLiftFrequency > 0.55
          ? l10n.detailedPenLiftSegmented
          : l10n.detailedPenLiftFluid,
    );
  }

  List<PsychologicalCue> exploratoryCues(AppLocalizations l10n) {
    return [_loadCue(l10n), _stabilityCue(l10n), _rhythmCue(l10n)];
  }

  String wellbeingSuggestion(AppLocalizations l10n) {
    switch (overallSignal) {
      case MetricSignal.green:
        return l10n.wellbeingSuggestionGreen;
      case MetricSignal.orange:
        return l10n.wellbeingSuggestionOrange;
      case MetricSignal.red:
        return l10n.wellbeingSuggestionRed;
    }
  }

  String confidenceAdvice(AppLocalizations l10n) {
    if (confidenceScore >= 0.82) {
      return l10n.confidenceAdviceHigh;
    }
    if (confidenceScore >= 0.50) {
      return l10n.confidenceAdviceMedium;
    }
    return l10n.confidenceAdviceLow;
  }

  List<ProfileMetric> detailedMetrics(AppLocalizations l10n) {
    return [
      ProfileMetric(
        name: l10n.metricBaselineName,
        valueText: '${baselineAngle.toStringAsFixed(1)}°',
        normalizedValue: ((baselineAngle + 12) / 24).clamp(0.0, 1.0),
        signal: _baselineSignal(),
        explanation: l10n.metricBaselineExplanation,
        ruleText: l10n.metricBaselineRule,
      ),
      ProfileMetric(
        name: l10n.metricSlantName,
        valueText: '${slantAngle.toStringAsFixed(1)}°',
        normalizedValue: ((slantAngle + 22) / 44).clamp(0.0, 1.0),
        signal: _slantSignal(),
        explanation: l10n.metricSlantExplanation,
        ruleText: l10n.metricSlantRule,
      ),
      ProfileMetric(
        name: l10n.metricPressureName,
        valueText: pressureIndex.toStringAsFixed(2),
        normalizedValue: pressureIndex.clamp(0.0, 1.0),
        signal: _pressureSignal(),
        explanation: l10n.metricPressureExplanation,
        ruleText: l10n.metricPressureRule,
      ),
      ProfileMetric(
        name: l10n.metricSpacingName,
        valueText: spacingRatio.toStringAsFixed(2),
        normalizedValue: (spacingRatio / 2.4).clamp(0.0, 1.0),
        signal: _spacingSignal(),
        explanation: l10n.metricSpacingExplanation,
        ruleText: l10n.metricSpacingRule,
      ),
      ProfileMetric(
        name: l10n.metricSizeVarianceName,
        valueText: letterSizeVariance.toStringAsFixed(2),
        normalizedValue: letterSizeVariance.clamp(0.0, 1.0),
        signal: _sizeVarianceSignal(),
        explanation: l10n.metricSizeVarianceExplanation,
        ruleText: l10n.metricSizeVarianceRule,
      ),
      ProfileMetric(
        name: l10n.metricPenLiftsName,
        valueText: penLiftFrequency.toStringAsFixed(2),
        normalizedValue: penLiftFrequency.clamp(0.0, 1.0),
        signal: _penLiftSignal(),
        explanation: l10n.metricPenLiftsExplanation,
        ruleText: l10n.metricPenLiftsRule,
      ),
    ];
  }

  MetricSignal get confidenceSignal {
    if (confidenceScore >= 0.82) {
      return MetricSignal.green;
    }
    if (confidenceScore >= 0.50) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal get overallSignal {
    final signals = [
      _baselineSignal(),
      _slantSignal(),
      _pressureSignal(),
      _spacingSignal(),
      _sizeVarianceSignal(),
      _penLiftSignal(),
    ];

    var red = 0;
    var orange = 0;
    var green = 0;

    for (final signal in signals) {
      switch (signal) {
        case MetricSignal.red:
          red++;
          break;
        case MetricSignal.orange:
          orange++;
          break;
        case MetricSignal.green:
          green++;
          break;
      }
    }

    if (red >= 3 || (red == 2 && orange >= 3)) {
      return MetricSignal.red;
    }
    if (red == 2) {
      return MetricSignal.orange;
    }
    if (red == 1) {
      if (orange >= 3) {
        return MetricSignal.red;
      }
      return MetricSignal.orange;
    }
    if (orange <= 2 && red == 0) {
      return MetricSignal.green;
    }
    if (orange <= 4 && red == 0) {
      return MetricSignal.orange;
    }
    if (green >= 4 && red == 0) {
      return MetricSignal.green;
    }
    return MetricSignal.orange;
  }

  String overallStateSummary(AppLocalizations l10n) {
    switch (overallSignal) {
      case MetricSignal.green:
        return l10n.overallSummaryGreen;
      case MetricSignal.orange:
        return l10n.overallSummaryOrange;
      case MetricSignal.red:
        return l10n.overallSummaryRed;
    }
  }

  String overallStateDescription(AppLocalizations l10n) {
    switch (overallSignal) {
      case MetricSignal.green:
        return l10n.overallDescriptionGreen;
      case MetricSignal.orange:
        return l10n.overallDescriptionOrange;
      case MetricSignal.red:
        return l10n.overallDescriptionRed;
    }
  }

  String _baselineMeaning(AppLocalizations l10n) {
    if (baselineAngle > 2.0) {
      return l10n.quickBaselineUp;
    }
    if (baselineAngle < -2.0) {
      return l10n.quickBaselineDown;
    }
    return l10n.quickBaselineStable;
  }

  String _slantMeaning(AppLocalizations l10n) {
    if (slantAngle > 6.0) {
      return l10n.quickSlantRight;
    }
    if (slantAngle < -6.0) {
      return l10n.quickSlantLeft;
    }
    return l10n.quickSlantNeutral;
  }

  String _pressureMeaning(AppLocalizations l10n) {
    if (pressureIndex > 0.68) {
      return l10n.psychPressureHigh;
    }
    if (pressureIndex < 0.38) {
      return l10n.psychPressureLow;
    }
    return l10n.psychPressureBalanced;
  }

  MetricSignal _baselineSignal() {
    final abs = baselineAngle.abs();
    if (abs <= 4.0) {
      return MetricSignal.green;
    }
    if (abs <= 8.1) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal _slantSignal() {
    final abs = slantAngle.abs();
    if (abs <= 11.25) {
      return MetricSignal.green;
    }
    if (abs <= 18.0) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal _pressureSignal() {
    if (pressureIndex >= 0.38 && pressureIndex <= 0.68) {
      return MetricSignal.green;
    }
    if (pressureIndex >= 0.28 && pressureIndex <= 0.78) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal _spacingSignal() {
    if (spacingRatio >= 0.89 && spacingRatio <= 1.48) {
      return MetricSignal.green;
    }
    if (spacingRatio >= 0.66 && spacingRatio <= 1.82) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal _sizeVarianceSignal() {
    if (letterSizeVariance <= 0.38) {
      return MetricSignal.green;
    }
    if (letterSizeVariance <= 0.59) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  MetricSignal _penLiftSignal() {
    if (penLiftFrequency <= 0.41) {
      return MetricSignal.green;
    }
    if (penLiftFrequency <= 0.63) {
      return MetricSignal.orange;
    }
    return MetricSignal.red;
  }

  PsychologicalCue _loadCue(AppLocalizations l10n) {
    if (pressureIndex >= 0.78 ||
        (penLiftFrequency > 0.63 && letterSizeVariance > 0.59)) {
      return PsychologicalCue(
        title: l10n.psychCueStress,
        detail: l10n.psychCueStressDetail,
        signal: MetricSignal.red,
      );
    }
    if (overallSignal == MetricSignal.green &&
        pressureIndex >= 0.36 &&
        pressureIndex <= 0.62 &&
        penLiftFrequency <= 0.41 &&
        letterSizeVariance <= 0.38) {
      return PsychologicalCue(
        title: l10n.psychCueSerenity,
        detail: l10n.psychCueSerenityDetail,
        signal: MetricSignal.green,
      );
    }
    return PsychologicalCue(
      title: l10n.psychCueActivation,
      detail: l10n.psychCueActivationDetail,
      signal: MetricSignal.orange,
    );
  }

  PsychologicalCue _stabilityCue(AppLocalizations l10n) {
    if (baselineAngle.abs() > 8.1 ||
        (letterSizeVariance > 0.59 && penLiftFrequency > 0.41)) {
      return PsychologicalCue(
        title: l10n.psychCueDiscontinuity,
        detail: l10n.psychCueDiscontinuityDetail,
        signal: MetricSignal.red,
      );
    }
    if (baselineAngle.abs() <= 4.0 &&
        letterSizeVariance <= 0.38 &&
        spacingRatio >= 0.89 &&
        spacingRatio <= 1.48) {
      return PsychologicalCue(
        title: l10n.psychCueStability,
        detail: l10n.psychCueStabilityDetail,
        signal: MetricSignal.green,
      );
    }
    return PsychologicalCue(
      title: l10n.psychCueSensitivity,
      detail: l10n.psychCueSensitivityDetail,
      signal: MetricSignal.orange,
    );
  }

  PsychologicalCue _rhythmCue(AppLocalizations l10n) {
    if (penLiftFrequency > 0.63 ||
        (letterSizeVariance > 0.59 && baselineAngle.abs() > 8.1)) {
      return PsychologicalCue(
        title: l10n.psychCueFragmentation,
        detail: l10n.psychCueFragmentationDetail,
        signal: MetricSignal.red,
      );
    }
    if (penLiftFrequency <= 0.41 &&
        letterSizeVariance <= 0.38 &&
        baselineAngle.abs() <= 4.0) {
      return PsychologicalCue(
        title: l10n.psychCueFluidity,
        detail: l10n.psychCueFluidityDetail,
        signal: MetricSignal.green,
      );
    }
    return PsychologicalCue(
      title: l10n.psychCueVariability,
      detail: l10n.psychCueVariabilityDetail,
      signal: MetricSignal.orange,
    );
  }
}

class PsychologicalCue {
  const PsychologicalCue({
    required this.title,
    required this.detail,
    required this.signal,
  });

  final String title;
  final String detail;
  final MetricSignal signal;
}

class ProfileMetric {
  const ProfileMetric({
    required this.name,
    required this.valueText,
    required this.normalizedValue,
    required this.signal,
    required this.explanation,
    required this.ruleText,
  });

  final String name;
  final String valueText;
  final double normalizedValue;
  final MetricSignal signal;
  final String explanation;
  final String ruleText;
}

enum MetricSignal { green, orange, red }
