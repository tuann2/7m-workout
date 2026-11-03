# 0004 Shared Catalog And Test Fixtures

Date: 2026-11-03

## Status

Accepted

## Context

[Decision 0001](0001-native-ios-and-android-apps.md) implements every feature
twice. Workout content and timing rules must not drift between the Kotlin and
Swift code, and `AGENTS.md` requires product rules to live in `docs/product/`.

## Decision

- `docs/product/catalog/` holds the only copy of the content catalog
  (exercises, workouts, Smart Workout templates) as JSON with a
  `schemaVersion`.
- A script copies the catalog and media into `android/app/src/main/assets/`
  and `ios/SevenMinWorkout/`. `scripts/validate.sh` fails when a copy differs
  from the source.
- Engine behavior (session timeline, cue times, Smart Workout generation, level
  suggestions) is pinned by shared JSON fixtures of inputs and expected
  outputs. Kotlin and Swift unit tests both run every fixture.
- Both platforms use the same seeded random number generator (for example
  SplitMix64) so the same inputs and seed give the same Smart Workout.

## Alternatives Considered

1. Kotlin Multiplatform shared engine: one implementation, but it changes the
   native-only approach accepted in decision 0001.
2. Separate catalog copies maintained by hand per platform: drift is likely and
   hard to detect.

## Consequences

Positive:

- A rule change shows up as a fixture change that both platforms must pass.
- Content edits happen in one place.

Tradeoffs:

- The engine is still written twice.
- The copy step must run before builds; validation catches forgotten copies.

## Follow-Up

- Implement the copy script, drift check and first fixtures in M1.
