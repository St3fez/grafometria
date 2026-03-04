import 'package:flutter/foundation.dart';

class AdUnitIds {
  const AdUnitIds._();

  // Test IDs. Replace with your production IDs before release.
  static const _androidBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _androidInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const _iosBanner = 'ca-app-pub-3940256099942544/2934735716';
  static const _iosInterstitial = 'ca-app-pub-3940256099942544/4411468910';

  static String? get banner {
    if (kIsWeb) {
      return null;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _androidBanner;
      case TargetPlatform.iOS:
        return _iosBanner;
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
        return _androidInterstitial;
      case TargetPlatform.iOS:
        return _iosInterstitial;
      default:
        return null;
    }
  }
}
