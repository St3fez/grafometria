import 'package:flutter/foundation.dart';

class AdUnitIds {
  const AdUnitIds._();

  static const _googleTestPublisherId = 'ca-app-pub-3940256099942544';
  static const _prodAndroidAppId = 'ca-app-pub-2298338132778992~7100989410';
  static const _prodAndroidBanner = 'ca-app-pub-2298338132778992/3161744400';
  static const _prodAndroidInterstitial =
      'ca-app-pub-2298338132778992/2359531728';
  static const _debugAndroidAppId = 'ca-app-pub-3940256099942544~3347511713';
  static const _debugAndroidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _debugAndroidInterstitial =
      'ca-app-pub-3940256099942544/1033173712';
  static const _debugIosAppId = 'ca-app-pub-3940256099942544~1458002511';
  static const _debugIosBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const _debugIosInterstitial = 'ca-app-pub-3940256099942544/4411468910';

  static const _androidAppId = String.fromEnvironment(
    'ADMOB_ANDROID_APP_ID',
    defaultValue: _prodAndroidAppId,
  );
  static const _androidBanner = String.fromEnvironment(
    'ADMOB_ANDROID_BANNER_ID',
    defaultValue: _prodAndroidBanner,
  );
  static const _androidInterstitial = String.fromEnvironment(
    'ADMOB_ANDROID_INTERSTITIAL_ID',
    defaultValue: _prodAndroidInterstitial,
  );
  static const _iosAppId = String.fromEnvironment(
    'ADMOB_IOS_APP_ID',
    defaultValue: '',
  );
  static const _iosBanner = String.fromEnvironment(
    'ADMOB_IOS_BANNER_ID',
    defaultValue: '',
  );
  static const _iosInterstitial = String.fromEnvironment(
    'ADMOB_IOS_INTERSTITIAL_ID',
    defaultValue: '',
  );

  static bool get shouldInitializeSdk => appId != null;

  static String? get appId {
    if (kIsWeb) {
      return null;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _resolveId(
          configured: _androidAppId,
          debugFallback: _debugAndroidAppId,
        );
      case TargetPlatform.iOS:
        return _resolveId(configured: _iosAppId, debugFallback: _debugIosAppId);
      default:
        return null;
    }
  }

  static String? get banner {
    if (kIsWeb) {
      return null;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _resolveId(
          configured: _androidBanner,
          debugFallback: _debugAndroidBanner,
        );
      case TargetPlatform.iOS:
        return _resolveId(
          configured: _iosBanner,
          debugFallback: _debugIosBanner,
        );
      default:
        return null;
    }
  }

  static String? get interstitial {
    if (kIsWeb) {
      return null;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _resolveId(
          configured: _androidInterstitial,
          debugFallback: _debugAndroidInterstitial,
        );
      case TargetPlatform.iOS:
        return _resolveId(
          configured: _iosInterstitial,
          debugFallback: _debugIosInterstitial,
        );
      default:
        return null;
    }
  }

  static String? _resolveId({
    required String configured,
    required String debugFallback,
  }) {
    final trimmed = configured.trim();
    if (trimmed.isNotEmpty) {
      if (kDebugMode || !_isGoogleTestId(trimmed)) {
        return trimmed;
      }
      return null;
    }
    if (kDebugMode) {
      return debugFallback;
    }
    return null;
  }

  static bool _isGoogleTestId(String value) {
    return value.startsWith(_googleTestPublisherId);
  }
}
