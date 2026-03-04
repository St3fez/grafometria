# Play Store Publication Checklist (HandwritingAnalysis)

Last review date: March 4, 2026

## 1) Mandatory public links
- Privacy Policy URL:
  - `https://st3fez.github.io/grafometria/privacy-policy.html`
- No other public legal pages are required for current release.

## 2) Store listing alignment
- App name shown: `HandwritingAnalysis`.
- Short/full description must state:
  - educational and non-diagnostic purpose;
  - camera live only;
  - no gallery import.
- Mention Pro unlock is per-result purchase.

## 3) Data Safety form (verify before submit)
Because SDK behavior and Play questions can evolve, re-check at submission time.

Suggested declarations to verify:
- Data collected by app/SDKs:
  - Device or other identifiers (ads/billing SDK context).
  - Purchase history / transaction info (Google Play Billing).
- Data shared:
  - Ad identifiers through ad network stack in Free mode.
- Data processing purposes:
  - App functionality.
  - Analytics/ads (if enabled in final build).
  - Fraud prevention and billing integrity (store-side).
- Security:
  - Data in transit encrypted (per provider/platform standards).

## 4) Ads declaration
- Mark app as containing ads in Play Console (Free mode shows banner/interstitial).

## 5) In-app products
- Product ID in code: `pro_report_099`.
- Confirm product exists in Play Console with localized title/description.
- Confirm test accounts for billing flows.

## 6) Internal/Open testing
- If testers must access Pro without real charges:
  - Configure Play license testers and test tracks.
  - Optionally publish promo codes if needed.
- Validate:
  - Pro unlock button navigation works.
  - Pro tab opens and shows complete metrics.
  - No ads after Pro unlock for current result.

## 7) Compliance wording checks
- Keep in-app and public docs consistent:
  - no diagnosis claim;
  - no guaranteed disease detection;
  - red/orange/green are screening-style markers.
- Keep contact information updated in Play developer profile.

## 8) Release artifacts
- Upload signed AAB built from release config.
- Verify package name consistency: `com.grafometria.grafometria`.
- Check version code and version name increments.
