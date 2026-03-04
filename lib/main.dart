import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'src/app.dart';

const _forceNoMonetizationForDebug = bool.fromEnvironment(
  'FORCE_NO_MONETIZATION',
  defaultValue: false,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await MobileAds.instance.initialize();
  }
  runApp(
    GrafometriaApp(
      enableMonetization: !_forceNoMonetizationForDebug,
    ),
  );
}
