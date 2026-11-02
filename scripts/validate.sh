#!/usr/bin/env bash
# Repository validation entrypoint. Usage: scripts/validate.sh [ios|android|all]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGET="${1:-all}"
IOS_DESTINATION="${IOS_DESTINATION:-platform=iOS Simulator,name=iPhone 17}"

validate_ios() {
  echo "==> iOS: build and unit tests ($IOS_DESTINATION)"
  xcodebuild test \
    -project "$ROOT/ios/SevenMinWorkout.xcodeproj" \
    -scheme SevenMinWorkout \
    -destination "$IOS_DESTINATION" \
    -derivedDataPath "$ROOT/ios/build/DerivedData" \
    -quiet
}

validate_android() {
  echo "==> Android: assemble, unit tests, lint"
  (cd "$ROOT/android" && ./gradlew assembleDebug testDebugUnitTest lintDebug --console=plain)
}

case "$TARGET" in
  ios) validate_ios ;;
  android) validate_android ;;
  all) validate_ios; validate_android ;;
  *) echo "Unknown target: $TARGET (expected ios, android, or all)" >&2; exit 2 ;;
esac

echo "==> validate.sh $TARGET: OK"
