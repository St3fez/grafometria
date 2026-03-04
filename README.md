# HandwritingAnalysis (Android MVP)

Android-first Flutter app for educational handwriting insights.

## Current Product Setup
- Localized UI (`en`, `it`, `es`, `fr`, `de`) via Flutter `gen-l10n`.
- In-app language selector (AppBar) with saved preference and system-default option.
- Live camera only (`ImageSource.camera`).
- No gallery/file picker access.
- Temporary camera file cleanup after processing (best-effort).
- Result shown in a modern popup with tabs (`Free`, `Pro`, `Share`).
- Last analysis result (free/pro unlock state) is kept in memory until app process kill.
- Traffic-light indicators for metrics (`GREEN`, `ORANGE`, `RED`).
- Free mode:
  - banner ads;
  - interstitial ad before result;
  - basic easy-to-read profile.
- Pro mode (per result):
  - unlock button at `€0.99`;
  - no ads for that analysis;
  - detailed profile + quantitative metrics (baseline, slant, pressure, spacing, size variance, pen lifts).
- Sharing options:
  - WhatsApp, Telegram, TikTok, Instagram, Facebook, system share.
- In-app policy workflow:
  - consent required before first analysis;
  - privacy/disclaimer sheet with withdraw-consent action.

## Dependencies in Use
- `image_picker` for live capture.
- `google_mobile_ads` for banner/interstitial.
- `in_app_purchase` for per-result unlock.
- `google_fonts` for modern typography.
- `flutter_localizations` + `intl` (SDK-pinned) for i18n.

## Product IDs / Ad IDs
- In-app product id: `pro_report_099`
- AdMob Android App ID (test): `ca-app-pub-3940256099942544~3347511713`
- Banner unit (test): `ca-app-pub-3940256099942544/6300978111`
- Interstitial unit (test): `ca-app-pub-3940256099942544/1033173712`

Replace test IDs with production values before store release.

## Run
```bash
flutter pub get
flutter run -d <android_device_id>
```

## Public URL for Play Console
Only the privacy policy page is intended as public URL for Play Console:
- [`docs/privacy-policy.html`](docs/privacy-policy.html)
- Live URL: `https://st3fez.github.io/grafometria/privacy-policy.html`

GitHub Pages root (`/`) redirects directly to privacy policy.

## Notes
- The analysis pipeline is deterministic V1 and runs locally on-device.
- Educational content only: not a medical or psychological diagnosis.
