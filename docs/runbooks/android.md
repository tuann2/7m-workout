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

## Readiness

`assembleDebug` ends with `BUILD SUCCESSFUL` and produces `app-debug.apk`.
On a device, the screen shows "7min Workout".

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

`./gradlew clean` removes build output. Stop only emulators this run started.

## Validation

`scripts/validate.sh android` runs `assembleDebug testDebugUnitTest lintDebug`.
Lint reports are written to `android/app/build/reports/`.

## Unknowns

- On-device launch is unverified: no Android Virtual Device existed when the
  project was created (2026-11-02).
- No unit tests exist yet; `testDebugUnitTest` currently runs nothing.
- Release signing key and launcher icon (lint warns `MissingApplicationIcon`).
- No CI pipeline exists yet.
