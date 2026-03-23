import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'src/app.dart';
import 'src/features/monetization/ad_unit_ids.dart';

const _forceNoMonetizationForDebug = bool.fromEnvironment(
  'FORCE_NO_MONETIZATION',
  defaultValue: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS) &&
      AdUnitIds.shouldInitializeSdk) {
    await MobileAds.instance.initialize();
  }
  runApp(GrafometriaApp(enableMonetization: !_forceNoMonetizationForDebug));
}
