import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafometria/l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../monetization/ad_unit_ids.dart';
import '../application/grafometry_analyzer.dart';
import '../domain/writer_profile.dart';

class AnalyzerPage extends StatefulWidget {
  const AnalyzerPage({
    super.key,
    this.enableMonetization = true,
    required this.onLocaleChanged,
    this.localeOverrideCode,
  });

  final bool enableMonetization;
  final ValueChanged<String?> onLocaleChanged;
  final String? localeOverrideCode;

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

enum _UnlockOutcome { unlocked, failed, canceled, unavailable }

enum _ShareTarget { whatsapp, telegram, tiktok, instagram, facebook, system }

class _AnalyzerPageState extends State<AnalyzerPage> {
  static const _proProductId = 'pro_report_099';
  static const _consentKey = 'graphometry_consent_v2';
  static const _consentVersion = 'consent_2026_03';
  static const _directShareChannel = MethodChannel(
    'com.grafometria.grafometria/direct_share',
  );
  static Uint8List? _sessionCapturedBytes;
  static WriterProfile? _sessionProfile;
  static bool _sessionProUnlockedForCurrentResult = false;

  final _picker = ImagePicker();
  final _analyzer = GrafometryAnalyzer();
  final _inAppPurchase = InAppPurchase.instance;
  final _shareTempFiles = <File>[];

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;
  Completer<_UnlockOutcome>? _purchaseCompleter;
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  Uint8List? _capturedBytes;
  WriterProfile? _profile;
  ProductDetails? _proProduct;

  bool _isAnalyzing = false;
  bool _isBannerReady = false;
  bool _storeAvailable = false;
  bool _purchasePending = false;
  bool _proUnlockedForCurrentResult = false;
  bool _isLoadingConsent = true;
  bool _hasComplianceConsent = false;
  bool _consentDraft = false;
  String? _infoMessage;
  String? _errorMessage;

  bool get _isWidgetTest => const bool.fromEnvironment('FLUTTER_TEST');
  AppLocalizations get _l10n => AppLocalizations.of(context)!;

  bool get _supportsMonetization {
    if (!widget.enableMonetization || kIsWeb || _isWidgetTest) {
      return false;
    }
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  String get _proPriceLabel => _proProduct?.price ?? '€0.99';

  @override
  void initState() {
    super.initState();
    _restoreSessionResult();
    if (_isWidgetTest) {
      _isLoadingConsent = false;
      _hasComplianceConsent = true;
      _consentDraft = true;
    } else {
      unawaited(_loadConsentState());
    }
    _recoverLostData();
    if (_supportsMonetization) {
      _initMonetization();
    }
  }

  void _restoreSessionResult() {
    if (_sessionCapturedBytes == null && _sessionProfile == null) {
      return;
    }
    _capturedBytes = _sessionCapturedBytes;
    _profile = _sessionProfile;
    _proUnlockedForCurrentResult = _sessionProUnlockedForCurrentResult;
  }

  @override
  void dispose() {
    _purchaseSubscription?.cancel();
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    for (final file in _shareTempFiles) {
      unawaited(() async {
        try {
          await file.delete();
        } catch (_) {}
      }());
    }
    super.dispose();
  }

  Future<void> _loadConsentState() async {
    final prefs = await SharedPreferences.getInstance();
    final accepted = prefs.getString(_consentKey) == _consentVersion;
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoadingConsent = false;
      _hasComplianceConsent = accepted;
      _consentDraft = accepted;
    });
  }

  Future<void> _saveConsent(bool accepted) async {
    if (_isWidgetTest) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    if (accepted) {
      await prefs.setString(_consentKey, _consentVersion);
    } else {
      await prefs.remove(_consentKey);
    }
  }

  void _initMonetization() {
    _purchaseSubscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdates,
      onError: (_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _purchasePending = false;
          _infoMessage = _l10n.purchaseStreamError;
        });
        _completePendingPurchase(_UnlockOutcome.failed);
      },
    );
    unawaited(_loadStoreProducts());
    _loadBannerAd();
    _loadInterstitialAd();
  }

  Future<void> _recoverLostData() async {
    final lostData = await _picker.retrieveLostData();
    if (lostData.isEmpty || lostData.file == null) {
      return;
    }
    await _analyzeCapture(lostData.file!);
  }

  Future<void> _captureLivePhoto() async {
    if (_isLoadingConsent) {
      return;
    }
    if (!_hasComplianceConsent) {
      await _openPolicySheet();
      return;
    }
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 92,
      maxWidth: 2200,
    );
    if (file == null) {
      return;
    }
    await _analyzeCapture(file);
  }

  Future<void> _analyzeCapture(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      await _eraseTemporaryCapture(file);
      setState(() {
        _capturedBytes = bytes;
        _profile = null;
        _errorMessage = null;
        _infoMessage = null;
        _isAnalyzing = true;
        _purchasePending = false;
        _proUnlockedForCurrentResult = false;
      });
      _sessionCapturedBytes = bytes;
      _sessionProfile = null;
      _sessionProUnlockedForCurrentResult = false;

      final profile = await _analyzer.analyze(bytes);
      await _showInterstitialBeforeResult();
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = profile;
        _isAnalyzing = false;
      });
      _sessionProfile = profile;
      await _openResultPopup();
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isAnalyzing = false;
        _profile = null;
        _errorMessage = _localizedAnalyzerError(error);
      });
    }
  }

  String _localizedAnalyzerError(Object error) {
    final raw = error.toString().replaceFirst(
      RegExp(r'^FormatException:\s*'),
      '',
    );
    switch (raw) {
      case 'Unsupported image format.':
        return _l10n.errorUnsupportedImageFormat;
      case 'Image too small. Capture a closer and sharper photo.':
        return _l10n.errorImageTooSmall;
      case 'Not enough handwriting detected. Try with better framing.':
        return _l10n.errorNotEnoughHandwriting;
      default:
        return raw;
    }
  }

  Future<void> _eraseTemporaryCapture(XFile file) async {
    if (kIsWeb || file.path.isEmpty) {
      return;
    }
    try {
      final cached = File(file.path);
      if (await cached.exists()) {
        await cached.delete();
      }
    } catch (_) {}
  }

  Future<void> _loadStoreProducts() async {
    final available = await _inAppPurchase.isAvailable();
    if (!mounted || !available) {
      setState(() {
        _storeAvailable = false;
      });
      return;
    }
    final response = await _inAppPurchase.queryProductDetails({_proProductId});
    if (!mounted) {
      return;
    }
    ProductDetails? product;
    for (final item in response.productDetails) {
      if (item.id == _proProductId) {
        product = item;
        break;
      }
    }
    setState(() {
      _storeAvailable = true;
      _proProduct = product;
    });
  }

  Future<_UnlockOutcome> _unlockProReport() async {
    if (_profile == null || _proUnlockedForCurrentResult || _purchasePending) {
      return _UnlockOutcome.unavailable;
    }
    if (kDebugMode) {
      setState(() {
        _purchasePending = false;
        _proUnlockedForCurrentResult = true;
        _infoMessage = _l10n.proReportUnlocked;
      });
      _sessionProUnlockedForCurrentResult = true;
      return _UnlockOutcome.unlocked;
    }
    if (!_supportsMonetization) {
      setState(() {
        _proUnlockedForCurrentResult = true;
      });
      _sessionProUnlockedForCurrentResult = true;
      return _UnlockOutcome.unlocked;
    }
    if (!_storeAvailable || _proProduct == null) {
      if (kDebugMode) {
        setState(() {
          _proUnlockedForCurrentResult = true;
          _infoMessage = _l10n.proReportUnlocked;
        });
        _sessionProUnlockedForCurrentResult = true;
        return _UnlockOutcome.unlocked;
      }
      setState(() {
        _infoMessage = _l10n.storeProductUnavailable(_proProductId);
      });
      return _UnlockOutcome.unavailable;
    }
    setState(() {
      _purchasePending = true;
      _infoMessage = _l10n.openingSecureCheckout;
    });
    final completer = Completer<_UnlockOutcome>();
    _purchaseCompleter = completer;
    try {
      final started = await _inAppPurchase.buyConsumable(
        purchaseParam: PurchaseParam(productDetails: _proProduct!),
      );
      if (!started) {
        if (kDebugMode) {
          setState(() {
            _purchasePending = false;
            _proUnlockedForCurrentResult = true;
            _infoMessage = _l10n.proReportUnlocked;
          });
          _sessionProUnlockedForCurrentResult = true;
          _completePendingPurchase(_UnlockOutcome.unlocked);
        }
        _completePendingPurchase(_UnlockOutcome.failed);
      }
    } catch (_) {
      if (kDebugMode) {
        setState(() {
          _purchasePending = false;
          _proUnlockedForCurrentResult = true;
          _infoMessage = _l10n.proReportUnlocked;
        });
        _sessionProUnlockedForCurrentResult = true;
        _completePendingPurchase(_UnlockOutcome.unlocked);
      }
      _completePendingPurchase(_UnlockOutcome.failed);
    }
    return completer.future.timeout(
      const Duration(seconds: 45),
      onTimeout: () {
        if (!mounted) {
          return _UnlockOutcome.failed;
        }
        if (kDebugMode) {
          setState(() {
            _purchasePending = false;
            _proUnlockedForCurrentResult = true;
            _infoMessage = _l10n.proReportUnlocked;
          });
          _sessionProUnlockedForCurrentResult = true;
          return _UnlockOutcome.unlocked;
        }
        setState(() {
          _purchasePending = false;
          _infoMessage = _l10n.purchaseFailed;
        });
        return _UnlockOutcome.failed;
      },
    );
  }

  void _completePendingPurchase(_UnlockOutcome outcome) {
    final pending = _purchaseCompleter;
    if (pending == null || pending.isCompleted) {
      return;
    }
    pending.complete(outcome);
  }

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          if (mounted) {
            setState(() {
              _purchasePending = true;
            });
          }
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if (mounted) {
            setState(() {
              _purchasePending = false;
              _proUnlockedForCurrentResult = true;
              _infoMessage = _l10n.proReportUnlocked;
            });
          }
          _sessionProUnlockedForCurrentResult = true;
          _completePendingPurchase(_UnlockOutcome.unlocked);
          break;
        case PurchaseStatus.error:
          if (mounted) {
            setState(() {
              _purchasePending = false;
              _infoMessage = purchase.error?.message ?? _l10n.purchaseFailed;
            });
          }
          _completePendingPurchase(_UnlockOutcome.failed);
          break;
        case PurchaseStatus.canceled:
          if (mounted) {
            setState(() {
              _purchasePending = false;
              _infoMessage = _l10n.purchaseCanceled;
            });
          }
          _completePendingPurchase(_UnlockOutcome.canceled);
          break;
      }
      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  void _loadBannerAd() {
    final unit = AdUnitIds.banner;
    if (unit == null) {
      return;
    }
    final banner = BannerAd(
      adUnitId: unit,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
            _isBannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          if (!mounted) {
            return;
          }
          setState(() {
            _isBannerReady = false;
            _bannerAd = null;
          });
        },
      ),
    );
    banner.load();
  }

  void _loadInterstitialAd() {
    final unit = AdUnitIds.interstitial;
    if (unit == null) {
      return;
    }
    InterstitialAd.load(
      adUnitId: unit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd?.dispose();
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (_) {
          _interstitialAd?.dispose();
          _interstitialAd = null;
        },
      ),
    );
  }

  Future<void> _showInterstitialBeforeResult() async {
    if (!_supportsMonetization || _proUnlockedForCurrentResult) {
      return;
    }
    final ad = _interstitialAd;
    if (ad == null) {
      _loadInterstitialAd();
      return;
    }
    final completer = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!completer.isCompleted) {
          completer.complete();
        }
        _loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        if (!completer.isCompleted) {
          completer.complete();
        }
        _loadInterstitialAd();
      },
    );
    _interstitialAd = null;
    ad.show();
    await completer.future.timeout(
      const Duration(seconds: 8),
      onTimeout: () {},
    );
  }

  Widget? _buildBanner() {
    if (_proUnlockedForCurrentResult || !_isBannerReady || _bannerAd == null) {
      return null;
    }
    return SafeArea(
      top: false,
      child: SizedBox(
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }

  Future<void> _openResultPopup() async {
    final profile = _profile;
    if (!mounted || profile == null) {
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) => _ResultPopup(
        profile: profile,
        proUnlocked: _proUnlockedForCurrentResult,
        priceLabel: _proPriceLabel,
        storeReady: _storeAvailable && _proProduct != null,
        onUnlock: _unlockProReport,
        onShare: _shareResultToTarget,
        onOpenPolicy: _openPolicySheet,
      ),
    );
  }

  String _shareText({required bool detailed}) {
    final profile = _profile!;
    final lines = <String>[
      _l10n.shareMyResult,
      profile.quickSummary(_l10n),
      _l10n.shareConfidenceLine(
        profile.confidenceLabel(_l10n),
        (profile.confidenceScore * 100).toStringAsFixed(0),
      ),
    ];
    if (detailed) {
      lines.add(_l10n.shareDetailedMetricsHeader);
      for (final metric in profile.detailedMetrics(_l10n)) {
        lines.add('- ${metric.name}: ${metric.valueText}');
      }
    } else {
      lines.add(_l10n.shareProHint);
    }
    lines.add(_l10n.shareTryApp);
    return lines.join('\n');
  }

  Future<XFile?> _buildShareCard({required bool detailed}) async {
    final profile = _profile;
    if (profile == null) {
      return null;
    }

    const width = 1080.0;
    final height = detailed ? 1820.0 : 1540.0;
    const padding = 72.0;
    final contentWidth = width - (padding * 2);
    final metrics = profile.detailedMetrics(_l10n);
    final shareMetrics = detailed ? metrics : metrics.take(3).toList();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      Paint()..color = const Color(0xFFF1F7F8),
    );

    final cardRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(28, 28, width - 56, height - 56),
      const Radius.circular(36),
    );
    canvas.drawRRect(cardRect, Paint()..color = Colors.white);

    double drawText(
      String text, {
      required double x,
      required double y,
      required TextStyle style,
      int? maxLines,
    }) {
      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
        maxLines: maxLines,
        ellipsis: '…',
      )..layout(maxWidth: contentWidth);
      painter.paint(canvas, Offset(x, y));
      return y + painter.height;
    }

    double drawPill(
      String text, {
      required double x,
      required double y,
      required Color background,
      required Color foreground,
    }) {
      final painter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: foreground,
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 2,
        ellipsis: '…',
      )..layout(maxWidth: contentWidth - 28);
      final pillHeight = painter.height + 20;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, contentWidth, pillHeight),
          const Radius.circular(999),
        ),
        Paint()..color = background,
      );
      painter.paint(canvas, Offset(x + 14, y + 10));
      return y + pillHeight;
    }

    final signal = profile.overallSignal;
    final signalTitle = _overallSignalTitle(signal, _l10n);
    final signalSummary = profile.overallStateSummary(_l10n);
    final confidenceLine = _l10n.reliabilityLine(
      profile.confidenceLabel(_l10n),
      (profile.confidenceScore * 100).toStringAsFixed(0),
    );

    var y = padding;
    y = drawText(
      _l10n.graphometryResult,
      x: padding,
      y: y,
      style: const TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.w800,
        color: Color(0xFF10212B),
      ),
      maxLines: 1,
    );
    y += 18;
    y = drawPill(
      signalTitle,
      x: padding,
      y: y,
      background: _signalBg(signal),
      foreground: _signalFg(signal),
    );
    y += 18;
    y = drawText(
      signalSummary,
      x: padding,
      y: y,
      style: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: Color(0xFF132028),
      ),
      maxLines: 3,
    );
    y += 10;
    y = drawText(
      confidenceLine,
      x: padding,
      y: y,
      style: const TextStyle(fontSize: 30, color: Color(0xFF4C5A66)),
      maxLines: 1,
    );
    y += 20;
    y = drawPill(
      detailed ? _l10n.tabPro : _l10n.tabFree,
      x: padding,
      y: y,
      background: detailed ? const Color(0xFFFFF2CC) : const Color(0xFFE8F6F4),
      foreground: detailed ? const Color(0xFF7A4C00) : const Color(0xFF0B5E57),
    );
    y += 18;

    y = drawText(
      detailed ? profile.detailedNarrative(_l10n) : profile.quickSummary(_l10n),
      x: padding,
      y: y,
      style: const TextStyle(
        fontSize: 31,
        color: Color(0xFF1A2A32),
        height: 1.3,
      ),
      maxLines: detailed ? 8 : 4,
    );
    y += 16;

    final bottomLimit = height - 180;
    for (final metric in shareMetrics) {
      final metricLine =
          '${metric.name}: ${metric.valueText} · ${_signalLabel(metric.signal, _l10n)}';
      y = drawText(
        metricLine,
        x: padding,
        y: y,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Color(0xFF14222A),
        ),
        maxLines: 1,
      );
      if (detailed) {
        y += 4;
        y = drawText(
          metric.explanation,
          x: padding,
          y: y,
          style: const TextStyle(
            fontSize: 26,
            color: Color(0xFF4C5A66),
            height: 1.3,
          ),
          maxLines: 2,
        );
      }
      y += 14;
      if (y > bottomLimit) {
        break;
      }
    }

    if (!detailed && y < bottomLimit) {
      y = drawPill(
        _l10n.freeProTeaserBody(_proPriceLabel),
        x: padding,
        y: y,
        background: const Color(0xFFE8F6F4),
        foreground: const Color(0xFF0B5E57),
      );
      y += 10;
    }

    drawText(
      _l10n.shareTryApp,
      x: padding,
      y: (y + 8).clamp(padding, height - 120).toDouble(),
      style: const TextStyle(fontSize: 26, color: Color(0xFF6A7884)),
      maxLines: 1,
    );

    final picture = recorder.endRecording();
    final rendered = await picture.toImage(width.toInt(), height.toInt());
    final pngBytes = (await rendered.toByteData(
      format: ui.ImageByteFormat.png,
    ))?.buffer.asUint8List();
    if (pngBytes == null) {
      return null;
    }
    final decoded = img.decodePng(pngBytes);
    if (decoded == null) {
      return null;
    }
    final jpegBytes = img.encodeJpg(decoded, quality: 90);
    final tempDir = await Directory.systemTemp.createTemp('grafometria_share_');
    final file = File(
      '${tempDir.path}${Platform.pathSeparator}result_'
      '${detailed ? 'pro' : 'free'}_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await file.writeAsBytes(jpegBytes, flush: true);
    _shareTempFiles.add(file);
    if (_shareTempFiles.length > 8) {
      final expired = _shareTempFiles.removeAt(0);
      unawaited(() async {
        try {
          await expired.delete();
        } catch (_) {}
      }());
    }
    return XFile(file.path, mimeType: 'image/jpeg');
  }

  Future<void> _shareResultToTarget(_ShareTarget target) async {
    if (_profile == null) {
      return;
    }
    final detailed = _proUnlockedForCurrentResult;
    var text = _shareText(detailed: detailed);
    if (target == _ShareTarget.whatsapp) {
      text = _truncateShareText(text, 900);
    }
    if (target == _ShareTarget.instagram || target == _ShareTarget.tiktok) {
      text = _truncateShareText(text, 280);
    }
    XFile? card;
    try {
      card = await _buildShareCard(detailed: detailed);
    } catch (_) {}

    if (defaultTargetPlatform == TargetPlatform.android &&
        (target == _ShareTarget.whatsapp || target == _ShareTarget.instagram)) {
      if (target == _ShareTarget.whatsapp) {
        final packages = <String>['com.whatsapp', 'com.whatsapp.w4b'];
        for (final packageName in packages) {
          final attempts = <Future<bool> Function()>[
            () => _shareDirectAndroid(
              packageName: packageName,
              text: text,
              imagePath: card?.path,
              includeTextWithImage: false,
            ),
            () => _shareDirectAndroid(
              packageName: packageName,
              text: text,
              imagePath: card?.path,
              includeTextWithImage: true,
            ),
            () => _shareDirectAndroid(
              packageName: packageName,
              text: text,
              imagePath: null,
              includeTextWithImage: false,
            ),
          ];
          for (final attempt in attempts) {
            if (await attempt()) {
              return;
            }
          }
        }

        final schemeUri = Uri.parse(
          'whatsapp://send?text=${Uri.encodeComponent(text)}',
        );
        if (await canLaunchUrl(schemeUri)) {
          await launchUrl(schemeUri, mode: LaunchMode.externalApplication);
          return;
        }
      } else {
        final shared = await _shareDirectAndroid(
          packageName: 'com.instagram.android',
          text: text,
          imagePath: card?.path,
          includeTextWithImage: false,
        );
        if (shared) {
          return;
        }
      }
    }

    final preferMediaOnly =
        target == _ShareTarget.instagram || target == _ShareTarget.tiktok;

    Future<void> shareAttempt({String? textPayload, List<XFile>? files}) async {
      await SharePlus.instance.share(
        ShareParams(
          text: textPayload,
          subject: _l10n.graphometryResult,
          files: files,
        ),
      );
    }

    try {
      await shareAttempt(
        textPayload: preferMediaOnly ? null : text,
        files: card == null ? null : [card],
      );
      return;
    } catch (_) {}

    if (card != null) {
      try {
        await shareAttempt(files: [card]);
        return;
      } catch (_) {}
    }

    try {
      await shareAttempt(textPayload: text);
      return;
    } catch (_) {
      if (target == _ShareTarget.whatsapp) {
        final uri = Uri.parse(
          'https://wa.me/?text=${Uri.encodeComponent(text)}',
        );
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          return;
        }
      }
    }

    return;
  }

  Future<bool> _shareDirectAndroid({
    required String packageName,
    required String text,
    String? imagePath,
    required bool includeTextWithImage,
  }) async {
    try {
      final result = await _directShareChannel
          .invokeMethod<bool>('shareToPackage', <String, dynamic>{
            'packageName': packageName,
            'text': text,
            'imagePath': imagePath,
            'mimeType': 'image/jpeg',
            'includeTextWithImage': includeTextWithImage,
          });
      return result ?? false;
    } catch (_) {
      return false;
    }
  }

  String _truncateShareText(String input, int maxChars) {
    if (input.length <= maxChars || maxChars < 8) {
      return input;
    }
    return '${input.substring(0, maxChars - 3)}...';
  }

  Future<void> _openPolicySheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => _PolicySheet(
        accepted: _hasComplianceConsent,
        onAccept: () async {
          await _saveConsent(true);
          if (!mounted) {
            return;
          }
          setState(() {
            _hasComplianceConsent = true;
            _consentDraft = true;
            _infoMessage = _l10n.privacyAccepted;
          });
        },
        onWithdraw: () async {
          await _saveConsent(false);
          if (!mounted) {
            return;
          }
          setState(() {
            _hasComplianceConsent = false;
            _consentDraft = false;
            _infoMessage = _l10n.consentWithdrawn;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          PopupMenuButton<String>(
            tooltip: l10n.languageTooltip,
            icon: const Icon(Icons.language_outlined),
            onSelected: (value) {
              final nextCode = value == 'system' ? null : value;
              widget.onLocaleChanged(nextCode);
            },
            itemBuilder: (context) {
              final selectedCode = widget.localeOverrideCode;
              PopupMenuItem<String> item(
                String value,
                String label, {
                required bool selected,
              }) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Expanded(child: Text(label)),
                      if (selected) const Icon(Icons.check_rounded, size: 18),
                    ],
                  ),
                );
              }

              return [
                item(
                  'system',
                  l10n.languageSystemDefault,
                  selected: selectedCode == null,
                ),
                item('en', 'English', selected: selectedCode == 'en'),
                item('it', 'Italiano', selected: selectedCode == 'it'),
                item('es', 'Espanol', selected: selectedCode == 'es'),
                item('fr', 'Francais', selected: selectedCode == 'fr'),
                item('de', 'Deutsch', selected: selectedCode == 'de'),
              ];
            },
          ),
          IconButton(
            onPressed: _openPolicySheet,
            icon: const Icon(Icons.policy_outlined),
            tooltip: l10n.privacyTooltip,
          ),
        ],
      ),
      bottomNavigationBar: _buildBanner(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F6F2), Color(0xFFF6FAFD)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerCard(
                  isBusy: _isAnalyzing || _purchasePending || _isLoadingConsent,
                ),
                const SizedBox(height: 12),
                const _TrustCard(),
                const SizedBox(height: 12),
                if (_isLoadingConsent)
                  _BusyCard(message: l10n.loadingPrivacySettings)
                else if (!_hasComplianceConsent)
                  _ConsentCard(
                    checked: _consentDraft,
                    onChecked: (value) => setState(() => _consentDraft = value),
                    onOpenPolicy: _openPolicySheet,
                    onAccept: () async {
                      if (!_consentDraft) {
                        setState(() {
                          _infoMessage = l10n.tickConsentBeforeContinuing;
                        });
                        return;
                      }
                      await _saveConsent(true);
                      if (!mounted) {
                        return;
                      }
                      setState(() {
                        _hasComplianceConsent = true;
                        _infoMessage = l10n.consentSavedCameraEnabled;
                      });
                    },
                  ),
                const SizedBox(height: 12),
                _ImagePreview(bytes: _capturedBytes),
                const SizedBox(height: 14),
                if (_infoMessage != null) ...[
                  _InfoCard(message: _infoMessage!),
                  const SizedBox(height: 12),
                ],
                if (_isAnalyzing)
                  _BusyCard(message: l10n.analyzingPreparingResultPopup)
                else if (_errorMessage != null)
                  _ErrorCard(message: _errorMessage!)
                else if (_profile != null)
                  _ResultReadyCard(
                    proUnlocked: _proUnlockedForCurrentResult,
                    onOpenResult: _openResultPopup,
                    onShare: () => _shareResultToTarget(_ShareTarget.system),
                  )
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        l10n.freeModeSummary(_proPriceLabel),
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerCard({required bool isBusy}) {
    final l10n = AppLocalizations.of(context)!;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF155E75)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.headerSubtitle,
              style: TextStyle(color: Color(0xFFE5F8F7), height: 1.35),
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: isBusy ? null : _captureLivePhoto,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0F766E),
              ),
              icon: const Icon(Icons.photo_camera_outlined),
              label: Text(l10n.captureLivePhoto),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustCard extends StatelessWidget {
  const _TrustCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _TrustPill(
              icon: Icons.videocam_outlined,
              label: l10n.trustLiveCameraOnly,
            ),
            _TrustPill(
              icon: Icons.folder_off_outlined,
              label: l10n.trustNoGalleryOrFile,
            ),
            _TrustPill(
              icon: Icons.auto_delete_outlined,
              label: l10n.trustTemporaryCleanup,
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustPill extends StatelessWidget {
  const _TrustPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFE7F4F2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF0F766E)),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsentCard extends StatelessWidget {
  const _ConsentCard({
    required this.checked,
    required this.onChecked,
    required this.onOpenPolicy,
    required this.onAccept,
  });

  final bool checked;
  final ValueChanged<bool> onChecked;
  final VoidCallback onOpenPolicy;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: const Color(0xFFFDF7E8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.gavel_outlined, color: Color(0xFF7A5B00)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.consentRequiredTitle,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(l10n.consentRequiredBody),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: checked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => onChecked(value ?? false),
              title: Text(l10n.consentCheckbox),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TextButton(
                  onPressed: onOpenPolicy,
                  child: Text(l10n.readPolicy),
                ),
                FilledButton(
                  onPressed: onAccept,
                  child: Text(l10n.acceptAndContinue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.bytes});

  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (bytes == null) {
      return Container(
        width: double.infinity,
        height: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0x33000000)),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(child: Text(l10n.noCaptureYet)),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.memory(
        bytes!,
        width: double.infinity,
        height: 230,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE9F3FF),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF144E84)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Color(0xFF144E84)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusyCard extends StatelessWidget {
  const _BusyCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(message, style: TextStyle(color: scheme.onErrorContainer)),
      ),
    );
  }
}

class _ResultReadyCard extends StatelessWidget {
  const _ResultReadyCard({
    required this.proUnlocked,
    required this.onOpenResult,
    required this.onShare,
  });

  final bool proUnlocked;
  final VoidCallback onOpenResult;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              proUnlocked
                  ? l10n.proPopupReadyTitle
                  : l10n.resultPopupReadyTitle,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(l10n.resultPopupBody),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: onOpenResult,
                  icon: const Icon(Icons.analytics_outlined),
                  label: Text(l10n.openResultPopup),
                ),
                OutlinedButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share_outlined),
                  label: Text(l10n.share),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultPopup extends StatefulWidget {
  const _ResultPopup({
    required this.profile,
    required this.proUnlocked,
    required this.priceLabel,
    required this.storeReady,
    required this.onUnlock,
    required this.onShare,
    required this.onOpenPolicy,
  });

  final WriterProfile profile;
  final bool proUnlocked;
  final String priceLabel;
  final bool storeReady;
  final Future<_UnlockOutcome> Function() onUnlock;
  final Future<void> Function(_ShareTarget target) onShare;
  final Future<void> Function() onOpenPolicy;

  @override
  State<_ResultPopup> createState() => _ResultPopupState();
}

class _ResultPopupState extends State<_ResultPopup>
    with SingleTickerProviderStateMixin {
  static final _scientificReferences = <_ScientificRef>[
    const _ScientificRef(
      title: 'MDS Clinical Diagnostic Criteria for Parkinson\'s Disease (2015)',
      source: 'Postuma RB et al., Movement Disorders, PMID: 26474316',
      url: 'https://pubmed.ncbi.nlm.nih.gov/26474316/',
    ),
    const _ScientificRef(
      title: 'Evaluation of handwriting in Parkinson diagnosis (2016)',
      source: 'Drotar P et al., Artificial Intelligence in Medicine',
      url: 'https://doi.org/10.1016/j.artmed.2016.03.004',
    ),
    const _ScientificRef(
      title: 'Handwriting changes in Alzheimer\'s disease: review (2023)',
      source: 'Review article, Journal of Alzheimer\'s Disease',
      url: 'https://pubmed.ncbi.nlm.nih.gov/35954551/',
    ),
  ];

  late bool _proUnlocked;
  late final TabController _tabController;
  bool _unlocking = false;
  String? _localMessage;

  @override
  void initState() {
    super.initState();
    _proUnlocked = widget.proUnlocked;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleUnlock() async {
    if (_unlocking || _proUnlocked) {
      return;
    }
    setState(() {
      _unlocking = true;
      _localMessage = null;
    });
    final result = await widget.onUnlock();
    if (!mounted) {
      return;
    }
    setState(() {
      _unlocking = false;
      final l10n = AppLocalizations.of(context)!;
      switch (result) {
        case _UnlockOutcome.unlocked:
          _proUnlocked = true;
          _localMessage = l10n.proUnlockedFullDataAvailable;
          break;
        case _UnlockOutcome.canceled:
          _localMessage = l10n.purchaseCanceled;
          break;
        case _UnlockOutcome.failed:
          _localMessage = l10n.purchaseFailed;
          break;
        case _UnlockOutcome.unavailable:
          _localMessage = l10n.storeProductUnavailableNow;
          break;
      }
    });
  }

  Future<void> _openReference(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context);
    final isCompact = media.size.width < 390;
    final clampedTextScaler = media.textScaler.clamp(
      minScaleFactor: 1.0,
      maxScaleFactor: isCompact ? 1.1 : 1.2,
    );
    final metrics = widget.profile.detailedMetrics(l10n);
    final freeMetrics = metrics.take(3).toList();
    final proOnlyIndicators = (metrics.length - freeMetrics.length).clamp(
      0,
      99,
    );
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: isCompact ? 8 : 12,
        vertical: isCompact ? 8 : 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: MediaQuery(
        data: media.copyWith(textScaler: clampedTextScaler),
        child: SizedBox(
          width: 720,
          height: media.size.height * (isCompact ? 0.92 : 0.88),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isCompact ? 12 : 14,
              isCompact ? 12 : 14,
              isCompact ? 12 : 14,
              isCompact ? 8 : 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.graphometryResult,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: isCompact ? 17 : 19,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                _SignalPill(
                  signal: widget.profile.overallSignal,
                  text: _overallSignalTitle(widget.profile.overallSignal, l10n),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.profile.overallStateSummary(l10n),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.reliabilityLine(
                    widget.profile.confidenceLabel(l10n),
                    (widget.profile.confidenceScore * 100).toStringAsFixed(0),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4C5A66),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.photoQualityShortLine(
                    (widget.profile.qualityGateScore * 100).toStringAsFixed(0),
                  ),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4C5A66),
                  ),
                ),
                const SizedBox(height: 10),
                TabBar(
                  controller: _tabController,
                  isScrollable: isCompact,
                  tabs: [
                    Tab(text: l10n.tabFree),
                    Tab(text: l10n.tabPro),
                    Tab(text: l10n.tabShare),
                  ],
                ),
                const SizedBox(height: 10),
                if (_localMessage != null) ...[
                  _InfoCard(message: _localMessage!),
                  const SizedBox(height: 10),
                ],
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(widget.profile.quickSummary(l10n)),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Card(
                              color: const Color(0xFFE8F6F4),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.freeProTeaserTitle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0B5E57),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      l10n.freeProTeaserBody(widget.priceLabel),
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: FilledButton.icon(
                                        onPressed: () {
                                          _tabController.animateTo(1);
                                          if (kDebugMode && !_proUnlocked) {
                                            unawaited(_handleUnlock());
                                          }
                                        },
                                        style: FilledButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF0F766E,
                                          ),
                                          foregroundColor: Colors.white,
                                          elevation: 1,
                                        ),
                                        icon: const Icon(
                                          Icons.workspace_premium_rounded,
                                        ),
                                        label: Text(
                                          l10n.freeProTeaserButton,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Card(
                              color: const Color(0xFFF8FAFB),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.legendTitle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(l10n.legendBody),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...freeMetrics.asMap().entries.map(
                              (entry) => _MetricLine(
                                metric: entry.value,
                                footerHint: entry.key == freeMetrics.length - 1
                                    ? l10n.proMoreIndicatorsHint(
                                        proOnlyIndicators,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _proUnlocked
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Text(
                                        widget.profile.detailedNarrative(l10n),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Card(
                                    color: const Color(0xFFF8FAFB),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        widget.profile.overallStateDescription(
                                          l10n,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Card(
                                    color: const Color(0xFFF8FAFB),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.scienceRefsTitle,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            l10n.scienceRefsDisclaimer,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF52616D),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          ..._scientificReferences.map(
                                            (ref) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: const Color(
                                                      0xFFD9E3E8,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ref.title,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        ref.source,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                            0xFF52616D,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 6),
                                                      TextButton.icon(
                                                        onPressed: () =>
                                                            _openReference(
                                                              ref.url,
                                                            ),
                                                        icon: const Icon(
                                                          Icons.open_in_new,
                                                          size: 16,
                                                        ),
                                                        label: Text(
                                                          l10n.openSource,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...metrics.map((m) => _MetricLine(metric: m)),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: const Color(0xFF0B3E4F),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            l10n.unlockFullPsychProfile,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            l10n.unlockFullPsychProfileBody,
                                            style: const TextStyle(
                                              color: Color(0xFFE1F5FB),
                                              height: 1.35,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: [
                                              _ValuePill(
                                                label: l10n.valuePsychReport,
                                              ),
                                              _ValuePill(
                                                label: l10n.valueRiskMarkers,
                                              ),
                                              _ValuePill(
                                                label:
                                                    l10n.valueNoAdsThisResult,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 14),
                                          FilledButton.icon(
                                            onPressed: _unlocking
                                                ? null
                                                : _handleUnlock,
                                            style: FilledButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(52),
                                              backgroundColor: const Color(
                                                0xFFFFD54F,
                                              ),
                                              foregroundColor: const Color(
                                                0xFF2B2200,
                                              ),
                                              elevation: 6,
                                              shadowColor: const Color(
                                                0x66000000,
                                              ),
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.workspace_premium_rounded,
                                            ),
                                            label: Text(
                                              _unlocking
                                                  ? l10n.processing
                                                  : l10n.unlockProForPrice(
                                                      widget.priceLabel,
                                                    ),
                                            ),
                                          ),
                                          if (!widget.storeReady) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              l10n.storeSetupPending,
                                              style: const TextStyle(
                                                color: Color(0xFFE1F5FB),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...metrics
                                      .take(4)
                                      .map(
                                        (m) => _MetricLine(
                                          metric: m,
                                          locked: true,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(l10n.sharePanelText),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _ShareButton(
                                  icon: Icons.chat_bubble_outline,
                                  label: l10n.whatsappLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.whatsapp),
                                ),
                                _ShareButton(
                                  icon: Icons.send_outlined,
                                  label: l10n.telegramLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.telegram),
                                ),
                                _ShareButton(
                                  icon: Icons.music_note_outlined,
                                  label: l10n.tiktokLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.tiktok),
                                ),
                                _ShareButton(
                                  icon: Icons.camera_alt_outlined,
                                  label: l10n.instagramLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.instagram),
                                ),
                                _ShareButton(
                                  icon: Icons.thumb_up_alt_outlined,
                                  label: l10n.facebookLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.facebook),
                                ),
                                _ShareButton(
                                  icon: Icons.ios_share_outlined,
                                  label: l10n.moreLabel,
                                  onTap: () =>
                                      widget.onShare(_ShareTarget.system),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: widget.onOpenPolicy,
                              child: Text(l10n.openPrivacyDisclaimer),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignalPill extends StatelessWidget {
  const _SignalPill({required this.signal, required this.text});

  final MetricSignal signal;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _signalBg(signal),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: _signalFg(signal),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ScientificRef {
  const _ScientificRef({
    required this.title,
    required this.source,
    required this.url,
  });

  final String title;
  final String source;
  final String url;
}

class _MetricLine extends StatelessWidget {
  const _MetricLine({
    required this.metric,
    this.locked = false,
    this.footerHint,
  });

  final ProfileMetric metric;
  final bool locked;
  final String? footerHint;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (locked) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.lock_outline, size: 16),
                  ),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    metric.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 56),
                  child: Text(
                    metric.valueText,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFeatures: [FontFeature.tabularFigures()],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: _SignalPill(
                signal: metric.signal,
                text: _signalLabel(metric.signal, l10n),
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: metric.normalizedValue,
                minHeight: 7,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              metric.explanation,
              style: const TextStyle(fontSize: 12, color: Color(0xFF3A4A56)),
            ),
            const SizedBox(height: 6),
            Text(
              metric.ruleText,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF5E6D78),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (footerHint != null) ...[
              const SizedBox(height: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF6F4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.workspace_premium_outlined,
                        size: 16,
                        color: Color(0xFF0B5E57),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          footerHint!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0B5E57),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShareButton extends StatelessWidget {
  const _ShareButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148,
      child: FilledButton.tonalIcon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

class _ValuePill extends StatelessWidget {
  const _ValuePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x2FFFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PolicySheet extends StatelessWidget {
  const _PolicySheet({
    required this.accepted,
    required this.onAccept,
    required this.onWithdraw,
  });

  final bool accepted;
  final Future<void> Function() onAccept;
  final Future<void> Function() onWithdraw;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.86,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.policyTitle,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(l10n.policyBody, style: TextStyle(height: 1.38)),
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 430;

                final withdrawButton = OutlinedButton.icon(
                  onPressed: () async {
                    await onWithdraw();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.block_outlined),
                  label: Text(
                    accepted ? l10n.withdrawConsent : l10n.keepDisabled,
                    overflow: TextOverflow.ellipsis,
                  ),
                );

                final acceptButton = FilledButton.icon(
                  onPressed: () async {
                    await onAccept();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(l10n.accept, overflow: TextOverflow.ellipsis),
                );

                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      withdrawButton,
                      const SizedBox(height: 10),
                      acceptButton,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: withdrawButton),
                    const SizedBox(width: 10),
                    Expanded(child: acceptButton),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

String _signalLabel(MetricSignal signal, AppLocalizations l10n) {
  switch (signal) {
    case MetricSignal.green:
      return l10n.signalBalance;
    case MetricSignal.orange:
      return l10n.signalVulnerability;
    case MetricSignal.red:
      return l10n.signalPotentialPathology;
  }
}

String _overallSignalTitle(MetricSignal signal, AppLocalizations l10n) {
  switch (signal) {
    case MetricSignal.green:
      return l10n.overallGreenTitle;
    case MetricSignal.orange:
      return l10n.overallOrangeTitle;
    case MetricSignal.red:
      return l10n.overallRedTitle;
  }
}

Color _signalFg(MetricSignal signal) {
  switch (signal) {
    case MetricSignal.green:
      return const Color(0xFF1E6A3A);
    case MetricSignal.orange:
      return const Color(0xFF9A5E00);
    case MetricSignal.red:
      return const Color(0xFF9B1C1C);
  }
}

Color _signalBg(MetricSignal signal) {
  switch (signal) {
    case MetricSignal.green:
      return const Color(0xFFE4F6E9);
    case MetricSignal.orange:
      return const Color(0xFFFFF3E1);
    case MetricSignal.red:
      return const Color(0xFFFCE8E8);
  }
}
