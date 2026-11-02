# Application Runbook: iOS App

## Scope

Build, test, and launch the SwiftUI app in `ios/` on the iOS Simulator.

## Prerequisites

- Xcode with an iOS Simulator runtime. Verified on 2026-11-02 with Xcode 27.2
  and the iOS 26.1 runtime.
- No package manager or CocoaPods; the project has no third-party dependencies.

## Start

```bash
cd ios
xcodebuild build -project SevenMinWorkout.xcodeproj -scheme SevenMinWorkout \
  -destination 'platform=iOS Simulator,name=iPhone 17' -derivedDataPath build/DerivedData
xcrun simctl boot "iPhone 17"
xcrun simctl install "iPhone 17" build/DerivedData/Build/Products/Debug-iphonesimulator/SevenMinWorkout.app
xcrun simctl launch "iPhone 17" vn.io.nt0.sevenminworkout
```

Or open `ios/SevenMinWorkout.xcodeproj` in Xcode and run the `SevenMinWorkout`
scheme. Build output is written to `ios/build/` (ignored by Git).

## Readiness

`simctl launch` prints `vn.io.nt0.sevenminworkout: <pid>` and the screen shows
"7min Workout".

## Deterministic State

The app stores no data yet. `xcrun simctl uninstall "iPhone 17"
vn.io.nt0.sevenminworkout` resets it.

## Interface

SwiftUI views live in `ios/SevenMinWorkout/`; tests (Swift Testing) live in
`ios/SevenMinWorkoutTests/`. `xcrun simctl io "iPhone 17" screenshot out.png`
captures the screen.

## Runtime Evidence

```bash
xcrun simctl spawn "iPhone 17" log stream --predicate 'process == "SevenMinWorkout"'
```

## Ownership And Cleanup

Shut down only simulators this run booted: `xcrun simctl shutdown "iPhone 17"`.
Delete `ios/build/` to drop build output.

## Validation

`scripts/validate.sh ios` runs `xcodebuild test` on the simulator. Override the
device with `IOS_DESTINATION='platform=iOS Simulator,name=<device>'`.

## Unknowns

- Apple development team and signing for physical devices / TestFlight.
- App icon artwork (`AppIcon` asset is empty).
- No CI pipeline exists yet.
