# Documentation Map

Start with the smallest authoritative surface.

## This Repository

- Root [`README.md`](../README.md): layout, quick start, Harness maintenance.
- `ios/`: SwiftUI app (`SevenMinWorkout.xcodeproj`, scheme `SevenMinWorkout`).
- `android/`: Kotlin + Jetpack Compose app (Gradle, module `:app`).
- `scripts/validate.sh`: repository validation entrypoint (`ios`, `android`,
  or `all`).

## Docs

- [`WORKFLOW.md`](WORKFLOW.md): repository understanding, missing
  capabilities, authority, and evidence.
- [`product/`](product/README.md): product behavior and intent. No product
  specification has been written yet; product rules are undecided until they
  appear here.
- [`decisions/`](decisions/README.md): lasting choices future work must
  inherit.
- [`runbooks/ios.md`](runbooks/ios.md) and
  [`runbooks/android.md`](runbooks/android.md): verified commands to build,
  test, and launch each app, plus known gaps.
- [`plans/`](plans/README.md): optional locations for multi-session plans.
- [`patterns/encoding-invariants.md`](patterns/encoding-invariants.md): turn
  accepted architecture, reliability, security, and quality rules into native
  mechanical validation.
- `templates/`: optional decision, plan, runbook, and Harness-improvement
  structures.

## Authority

Code, tests, build files, and observed app behavior are authoritative for
current implementation. Product intent lives in `docs/product/`; lasting
choices live in `docs/decisions/`.
