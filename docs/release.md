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

Normal release packaging, signature verification and emulator installation passed. Automated debug-mode tests exercised real API registration/restoration/logout and seven populated demo screens. Physical-device release acceptance and a fully recorded interactive walkthrough remain pending; screenshots are real emulator captures. Do not describe the debug acceptance as a release-device test.

[Completion status](https://github.com/CineMatePlus/cinemate_backend/blob/release/app-readiness/docs/completion-status.md) records remote CI and publication gates. iOS/web/desktop are unverified.

## Presentation artifact

[70-second screen tour](demo-screen-tour.mp4) is assembled from seven real emulator captures. Recreate it with `python3 scripts/make_screen_tour.py --ffmpeg=/path/to/ffmpeg`. This is a screenshot tour, not a full interactive recording.
