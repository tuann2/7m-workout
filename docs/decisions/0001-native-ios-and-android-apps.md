# 0001 Native iOS And Android Apps

Date: 2026-11-02

## Status

Accepted

## Context

The product ships on iOS and Android. A cross-platform framework (Expo /
React Native, Flutter) or two native codebases were the available options.
The repository owner chose native apps.

## Decision

Build two native apps in one repository:

- `ios/`: Swift + SwiftUI, Xcode project using file-system synchronized groups
  (files added under `ios/SevenMinWorkout/` join the target automatically).
- `android/`: Kotlin + Jetpack Compose, Gradle Kotlin DSL with a version
  catalog at `android/gradle/libs.versions.toml`.

Toolchain versions live in those build files, not in documentation.

## Alternatives Considered

1. Expo / React Native with TypeScript — one codebase, Node already installed.
2. Flutter — one Dart codebase; required installing Flutter SDK and CocoaPods.

## Consequences

Positive:

- Full access to platform APIs (HealthKit, Health Connect, notifications,
  background audio/timers) without bridges.
- Each app follows its platform's UI conventions and tooling.

Tradeoffs:

- Features are implemented twice; behavior parity must be kept deliberately.
- Product rules shared by both apps should be specified once in
  `docs/product/` and tested on each platform.

## Follow-Up

- Bundle ID / applicationId: `vn.io.nt0.sevenminworkout` on both platforms
  (chosen 2026-11-02). `vn.io.nt0.7minworkout` was rejected because Android
  package segments must start with a letter.
- Choose the Apple development team for device builds and signing.
- Confirm minimum OS versions (currently iOS 17.0, Android minSdk 26) and
  whether iPad is supported (currently iPhone + iPad).
