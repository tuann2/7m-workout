# Application Runbook: Android App

## Scope

Build, test, lint, and install the Jetpack Compose app in `android/`.

## Prerequisites

- JDK 17+ (verified with Temurin 17).
- Android SDK at `$ANDROID_HOME` with the platform matching `compileSdk` in
  `android/app/build.gradle.kts`. Without `ANDROID_HOME`, create
  `android/local.properties` with `sdk.dir=<path>` (ignored by Git).
- The Gradle wrapper downloads Gradle itself; versions are pinned in
  `android/gradle/wrapper/gradle-wrapper.properties` and
  `android/gradle/libs.versions.toml`.

## Start

```bash
cd android
./gradlew assembleDebug        # APK: app/build/outputs/apk/debug/app-debug.apk
./gradlew installDebug         # needs a running emulator or connected device
adb shell am start -n vn.io.nt0.sevenminworkout/.MainActivity
```

Or open `android/` in Android Studio and run the `app` configuration.

Project emulator (created 2026-11-03 from the installed
`system-images;android-35;google_apis;arm64-v8a`). Do not use other AVDs on
the machine; they belong to other projects.

```bash
SDK="$ANDROID_HOME"
# one-time creation
echo no | "$SDK/cmdline-tools/latest/bin/avdmanager" create avd -n sevenmin_api35 \
  -k "system-images;android-35;google_apis;arm64-v8a" -d pixel_7
# headless start, then wait for boot
"$SDK/emulator/emulator" -avd sevenmin_api35 -no-window -no-audio -no-snapshot -no-boot-anim &
adb wait-for-device shell 'while [ "$(getprop sys.boot_completed)" != "1" ]; do sleep 2; done'
```

## Readiness

`assembleDebug` ends with `BUILD SUCCESSFUL` and produces `app-debug.apk`.
On a device, the screen shows "7min Workout". Verified on 2026-11-03 on
`sevenmin_api35`: the emulator booted in about 20 s, `am start -W` reported
`LaunchState: COLD` and `TotalTime` about 1.5 s, and `uiautomator dump`
contained `text="7min Workout"`.

## Deterministic State

The app stores no data yet. `adb uninstall vn.io.nt0.sevenminworkout` resets it.

## Interface

Compose UI lives in `android/app/src/main/java/vn/io/nt0/sevenminworkout/`;
JVM unit tests go in `android/app/src/test/`.

## Runtime Evidence

```bash
adb logcat --pid="$(adb shell pidof vn.io.nt0.sevenminworkout)"
```

## Ownership And Cleanup

`./gradlew clean` removes build output. Stop only emulators this run started,
for example `adb -s emulator-5554 emu kill`.

## Validation

`scripts/validate.sh android` runs `assembleDebug testDebugUnitTest lintDebug`.
Lint reports are written to `android/app/build/reports/`.

## Unknowns

- Launch is verified on the emulator only; no physical device has run the app.
- No unit tests exist yet; `testDebugUnitTest` currently runs nothing.
- Release signing key and launcher icon (lint warns `MissingApplicationIcon`).
- No CI pipeline exists yet.
