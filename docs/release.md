# Android portfolio candidate — 1.0.0+1

Built on 6 September 2026 with the pinned toolchain in the README. The package is signed with a dedicated CineMate Portfolio key, not the Android debug key.

- APK: `cinemate-1.0.0-local-demo.apk` (external delivery artifact, not committed).
- SHA-256: `cb6776f32186ca4dfca7d6b4c59f8dc448457ad719fd28cc4cae5f7217420da1`
- Signing certificate SHA-256: `1a5d36f796876dc2390437892aefb3afff5351c589882fdb0e093acf51c61af6`
- Mobile application source: `d8526c2` (later tour/documentation-only commits do not change the APK).
- Package: `io.github.cinemateplus.cinemate`.
- API: `http://127.0.0.1:8013`; explicitly opted into local HTTP.
- Backend source: commit recorded in `.backend-ref`; subsequent bootstrap-only fixes do not change the API contract.

## Install

Start the backend with `cinemate_demo` on port 8013. Use the backend README to prepare films, indexes and synthetic accounts. Connect an Android emulator or USB-debugging device:

```sh
adb reverse tcp:8013 tcp:8013
adb install -r cinemate-1.0.0-local-demo.apk
```

If a debug build with a different signer is installed, uninstall that app first (this removes its local session), then install the release. Login with your locally configured demo password. The APK contains no demo password and needs a running backend. Keep the signing key and password outside Git, and retain them securely for compatible future updates.

## Evidence and limits

Normal release packaging, signature verification and emulator installation passed. Automated debug-mode tests exercised real API registration/restoration/logout and seven populated demo screens. A recorded Android emulator walkthrough covers the main demo flow. Physical-device release acceptance remains pending; screenshots are real emulator captures. Do not describe the debug acceptance as a release-device test.

[Completion status](https://github.com/CineMatePlus/cinemate_backend/blob/main/docs/completion-status.md) records remote CI and publication gates. iOS/web/desktop are unverified.

## Presentation artifact

[Android emulator walkthrough](demo-screen-tour.mp4) is a real screen recording of the integration-test flow: discovery, film details, semantic search, similar users, collections and profile. It uses synthetic demo data and does not represent a physical-device acceptance test.

## Main integration — 6 September 2026

Application changes were fast-forwarded to main after generation consistency, formatting, fatal-info analysis, 12 local tests, a standard debug APK build and the real-API Android registration/restore/logout test passed. The backend revision in `.backend-ref` is available on its main branch. Mobile remote CI remains unverified because repository API access is unavailable; physical-device release acceptance remains pending.
