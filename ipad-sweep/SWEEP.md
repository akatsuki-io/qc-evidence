# iPad layout sweep — before fix

Device: iPad Pro 11" (M5) simulator, iOS 26.4, portrait 834×1210pt. Figma file `TTFd1iJsEvyfHZ1pYz26mb`, page `2603:41267`.
Landscape: not captured separately — every landscape defect is the portrait defect made worse (wider window); the fix locks portrait via `requireFullScreen`.

Legend: **stretch** = content laid out across the full 834pt window (Figma frame is 402pt); **hero** = leaf hero sized from window width (`width*1.11 × width*1.08`) so it drifts to mid-screen and overlaps content; **component** = a component breaks on wide screens.

| # | Route (`mobile/app`) | iPad before | Figma node | Defect |
|---|---|---|---|---|
| 1 | `(onboarding)/index` | before/01-onboarding.png | 2603:41272 | stretch (CTA + copy full width; hero image sized from window) |
| 2 | `(auth)/sign-in` | before/03-sign-in.png | 2603:41335 | stretch + hero; logo 39pt fixed; "Login your account" at ~39% height (Figma 23%) — see B_02 / B_ipad-signin-logo |
| 3 | `(auth)/register` | before/03-register.png | 2603:41363 | stretch + hero |
| 4 | `(auth)/verify` | before/02-verify-portrait.png | 2603:41418 | stretch + hero + **component**: OTP cells ~130pt square, active cell shows a single gold vertical line; leaf overlaps Resend links |
| 5 | `(auth)/reset-verify` | before/03-reset-verify.png | 2603:41442 | same as verify |
| 6 | `(auth)/forgot-password` | before/03-forgot-password.png | 2603:41465 | stretch + hero |
| 7 | `(auth)/reset-password` | before/03-reset-password.png | 2603:41666 | stretch + hero |
| 8 | `(auth)/payment` | before/03-payment.png | 2603:41549 | stretch + hero (backend error state on dev, layout still assessable) |
| 9 | `(auth)/payment-card` | before/03-payment-card.png | 2603:41532 | stretch + hero |
| 10 | `(auth)/preferences` | before/03-preferences.png | 2603:41567 | stretch + hero |
| 11 | `(auth)/enable-biometrics` | before/03-enable-biometrics.png | 2603:41776 | stretch |
| 12 | `(auth)/account-success` | before/03-account-success.png | 2603:41484 | stretch |
| 13 | `(tabs)/index` (home) | before/04-home.png* | 2603:41940 | stretch + hero (*first capture shows enable-biometrics; home visible in after/) |
| 14 | `(tabs)/search` | before/05-search.png | 2603:42094 | stretch + hero (leaf mid-screen) |
| 15 | `(tabs)/bookings` | before/06-bookings.png | 2603:43478 | stretch + hero |
| 16 | `(tabs)/account` | before/07-account.png | 1221:34585 | stretch (cards full width) |
| 17 | `notifications` | before/08-notifications.png | 2603:42049 | stretch |
| 18 | `concierge` | before/09-concierge.png | 3759:14541 | stretch |
| 19 | `search/results` | before/10-search-results.png | 3802:22228 | stretch + hero |
| 20 | `search/map` | before/11-search-map.png | 2603:42391 | stretch (map fills width; provider cards full width) |
| 21 | `booking/index` | before/12-booking-index.png | 2603:42582 | stretch (empty state; hero not exercised without businessId) |
| 22 | `account/edit` | before/13-account-edit.png | 1221:34588 | stretch |
| 23 | `account/help` | before/14-account-help.png | 2603:45161 | stretch + hero |
| 24 | `account/legal/index` | before/15-account-legal.png | 2603:45061 | stretch + hero |
| 25 | `account/payment` | before/16-account-payment.png | 2603:44315 | stretch |
| 26 | `account/payment-card` | before/17-account-payment-card.png | 2603:44220 | stretch |
| 27 | `account/credits` | before/18-account-credits.png | 2603:44567 | stretch |
| 28 | `account/insurance` | before/19-account-insurance.png | 2603:44328 | stretch |
| 29 | `account/notifications` | before/20-account-notifications.png | 2603:44628 | stretch |
| 30 | `account/reviews` | before/21-account-reviews.png | 2603:44871 | stretch |
| 31 | `account/faq` | before/23-account-faq.png | 2603:45363 | stretch |
| 32 | `disputes/index` | before/26-disputes.png | 2603:43478 | stretch |
| 33 | `disputes/new` | before/27-disputes-new.png | 2603:45318 | stretch |
| 34 | `wallet/purchase` | before/28-wallet-purchase.png | 3058:31415 | stretch |
| 35 | `household/add-dependant/personal-info` | before/29-household-personal.png | — (WizardScreen) | stretch + hero |
| 36 | `household/add-dependant/permissions` | before/30-household-permissions.png | — (WizardScreen) | stretch + hero |
| 37 | `household/add-dependant/policy` | before/31-household-policy.png | — (WizardScreen) | stretch + hero |

Not captured (route needs live data ids): `business/[id]`, `booking/{time,confirm,success,failed}`, `bookings/[id]` + sub-routes, `account/{insurance-link,insurance-edit,receipt,legal/[slug]}`. They share the same root cause (window-width hero / no max-width) and are fixed by the same two shared changes; `bookings/[id]` and `business/[id]` are covered by the `useContentWidth` sweep.
Guessed paths that 404'd (not defects): `account/devices/security`, `account/financial`, `account/insights`, `account/help/support`.

**Total: 37 routes captured, 37 off vs Figma.** Root causes: (1) no max-width column in `app/_layout.tsx`; (2) 15 files size the hero from `useWindowDimensions().width`; (3) `CodeInput` cells `flex:1 + aspectRatio:1`; (4) iPad ignores the portrait lock without `requireFullScreen`.

---

# Status log (2026-09-19, for session continuity)

## Done
- Code fixes (commit `wip(mobile): iPad layout fixes + sweep evidence`): `app.json` `requireFullScreen:true`; `app/_layout.tsx` 480pt column (`CONTENT_MAX_WIDTH`); new `src/components/ui/useContentWidth.ts` used by WizardScreen + 14 width-reading screens; `CodeInput` row `maxWidth 60*length` + last-cell/active border fix; `sign-in.tsx` logo scales with column, `paddingTop heroH*0.32` (B_02), business link → `${env.businessPortalUrl}/business/onboarding` (B_01).
- Tests: `__tests__/ipad-content-width.test.tsx` (3 pass); `verify-autodetect`, `signup-recovery`, `reset-verify` 51 pass. `pnpm typecheck`: only 14 pre-existing errors in `server/skip-the-line/skip-service.ts` + `server/tax-credits/report-service.ts` (unchanged vs origin/develop); mobile clean.
- Audits: B_01 = Reproduced (external Safari link to portal `/auth/register-business`, page broken on iPad; fix path `/business/onboarding`). B_02 = Reproduced iPhone+iPad (title at ~39% vs Figma 23%), same root as CEO's iPad logo/leaf shot (`B_ipad-signin-logo` merged). B_03 = Not a bug (as designed): Figma 2603:41363 muted grey "Sign up" in empty state; app matches.
- iPad after shots so far: `after/00-launch, 03-sign-in (Home, bob logged in), 03-register, 02-verify-portrait, 03-forgot-password, 03-payment, 03-preferences, 03-enable-biometrics, 01-onboarding` — those taken while logged in redirect to Home (still valid proof of column clamp, not of the auth screen).
- iPhone (17 Pro) before shots: `iphone/B02-signin-open, B02-signin-after-back, B03-register-empty, B01-*`.

## Remaining (state at 2026-09-19 02:10)
- All capture/verdict work DONE (see After/Verdict). Evidence pushed to `akatsuki-io/qc-evidence` under `ipad-sweep/{before,after,iphone,sidebyside,figma}` (29 raw links verified 200).
- Native rebuild DONE: `expo prebuild` + `expo run:ios` on the iPad sim; installed bundle `Info.plist` reads `UIRequiresFullScreen=true`, `UISupportedInterfaceOrientations~ipad` = portrait only.
- Landscape visual check SKIPPED: Simulator rotation needs an Accessibility grant (osascript keystroke + `orca computer hotkey` both denied). Plist in the installed app is the evidence; state in PR.
- PR #1123 opened; board review rev2 (2026-09-19 02:00) → two blockers, both done below.

## Rev2 (board review, 2026-09-19)
- Blocker 1: `qc-evidence/` removed from the PR (`git rm -r --cached`), branch squashed to one commit. This file + `go.sh`/`shot.sh`/`sheet.py` live in `akatsuki-io/qc-evidence/ipad-sweep/`; the on-disk copy under the worktree is untracked.
- Blocker 2: hero + gradient were clipped to the 480 column (hard edge, leaf cut at column). In-screen negative-offset bleed does NOT work — the native Stack clips past screen bounds (tried, screenshot still showed the rectangle). Fix = `src/components/ui/HeroBackdrop.tsx`: screens register their hero via `useHeroBackdrop(HERO)`; root-level `HeroBackdropHost` in `app/_layout.tsx` paints it window-wide; screen root bg + root Stack `contentStyle` + `(auth)` Stack + `(tabs)` `sceneStyle` go transparent on iPad (`useBleeds()`). Applied to WizardScreen, sign-in, register, home, search, results, bookings, help, legal.
- Re-shot after (rev2): `after/03-sign-in, 03-register, 02-verify-portrait, 04-home, 05-search, 06-bookings, 14-account-help, 15-account-legal, 10-search-results` — leaf spans the full window, no column edge on any of them. `sidebyside/rev2-hero-bleed.png` = v1 after vs rev2 after (sign-in, home).
- Backend on dev returned errors for profile/bookings at capture time (`Couldn't load …` cards on home/bookings/account); layout unaffected, same as the v1 payment note.
- Tests rev2: `ipad-content-width` 5 (2 new HeroBackdrop), + `verify-autodetect`, `signup-recovery`, `reset-verify` → 4 suites / 56 pass. mobile `tsc --noEmit` clean apart from the pre-existing `locale.test.ts` TS2871.

## How to capture
- iPad Pro 11" (M5) iOS 26.4: `AC5E78B0-25E1-47ED-92FA-337D9388AFD9` (834×1210). iPhone 17 Pro iOS 26.4: `9C1028F9-C667-47E8-A093-BE44C0C25A14` (402×874).
- Metro: `mobile/` on :8081 (log `/tmp/ipad-metro.log`). Launch w/o alert: `xcrun simctl launch $UDID io.fillr.mobile.v2 --initialUrl 'http://localhost:8081'`, wait ~30s.
- `qc-evidence/ipad-sweep/go.sh <before|after> <name> /<route>` = openurl `fillrv2://<route>` + tap "Open" (59%,51%) + `shot.sh`. `WAIT=n` for slow screens. `shot.sh <dir> <name>` = plain screenshot.
- Dev login: bob@example.test / `Consumer!Pa$$1` (memory fallback; sheet has no consumer creds). Maestro `-e` vars don't substitute; write literal values.

## After / Verdict (fill as re-sweep proceeds)
| # | Route | After | Verdict |
|---|---|---|---|
| 1 | (onboarding)/index | after/01-onboarding.png | OK: hero image + copy + CTA inside 480 column |
| 2 | (auth)/sign-in | after/03-sign-in.png | OK: logo scales with column, leaf top-right, title directly under logo (sidebyside/B02.png) |
| 3 | (auth)/register | after/03-register.png | OK: matches 2603:41363 (sidebyside/B03.png) |
| 4 | (auth)/verify | after/02-verify-portrait.png | OK: 480 column, OTP cells ~60pt, active cell gold border, hero top-right |
| 5-12 | other (auth)/* | after/03-*.png | OK all (reset-verify, forgot-password, reset-password, payment [backend error state, layout OK], payment-card, preferences, enable-biometrics, account-success): 480 column, hero top-right |
| 13 | (tabs)/index | after/04-home.png | OK: centered column, tab bar aligned |
| 14 | (tabs)/search | after/05-search.png | OK |
| 15 | (tabs)/bookings | after/06-bookings.png | OK |
| 16 | (tabs)/account | after/07-account.png | OK |
| 17 | notifications | after/08-notifications.png | OK (re-shot; first shot had landed on Booking Details) |
| 18 | concierge | after/09-concierge.png | OK; glow confined to column (see note) |
| 19 | search/results | after/10-search-results.png | OK |
| 20 | search/map | after/11-search-map.png | OK (map fills column) |
| 21 | booking/index | after/12-booking-index.png | OK (empty state) |
| 22-31 | account/* | after/13…23-*.png | OK all (edit, help, legal, payment, payment-card, credits, insurance, notifications, reviews, faq) |
| 32-33 | disputes, disputes/new | after/26,27-*.png | OK |
| 34 | wallet/purchase | after/28-wallet-purchase.png | OK |
| 35-37 | household/add-dependant/* | after/29,30,31-*.png | OK: hero top-right, column centered |

## Bug-sheet items
| Bug | After | Verdict |
|---|---|---|
| B_01 | after/B01-business-onboarding-ipad.png, iphone/B01-business-onboarding-after.png, sidebyside/B01.png | Fixed: "Register your Business" now opens `/business/onboarding` (full 6-step wizard on iPad Safari + iPhone) |
| B_02 | iphone/B02-signin-open-after.png, after/03-sign-in.png, sidebyside/B02.png | Fixed: title at ~25% height on iPhone (Figma 23%, was ~39%); iPad column + scaled logo |
| B_03 | sidebyside/B03.png | Not a bug: Figma 2603:41363 shows muted "Sign up" in empty state, app matches |
| B_ipad-1 (verify OTP) | sidebyside/B_ipad-1-verify.png | Fixed: cells ~60pt, gold border on active cell, leaf top-right |
