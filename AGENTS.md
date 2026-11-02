# Agent Instructions

<!-- HARNESS:BEGIN -->
## Harness

Start with the requested outcome and use the repository as the system of record.
Read `docs/WORKFLOW.md` and only relevant product, design, plan, code, and
validation material.

- Answers, explanations, reviews, diagnoses, plans, and status reports are
  read-only. Inspect only what is needed; change nothing.
- For a bounded change, inspect affected behavior and proof, implement, and
  validate. No control-plane operation is required.
- Use one `docs/plans/active/` file when work spans sessions, coordinates
  contributors, has dependencies, or needs recovery. Move it to
  `docs/plans/completed/` only after validation.
- Before editing, identify repository authority for each new externally
  observable policy. If materially different choices remain open, stop before
  edits; configurable defaults are not authority.
- For architecture, reliability, security, or quality invariant work, read
  `docs/patterns/encoding-invariants.md` and enforce only accepted rules.
- Report reusable agent friction. Change guidance, tools, runbooks, or validation
  for that purpose only when explicitly asked to use `$improve-harness`.
- Also pause when product intent remains ambiguous, recovery is difficult,
  validation is weakened, or authority is insufficient.
- Claim completion only with executable or observable evidence. Report outcome,
  changes, validation, and unresolved risks.

Harness has no task database or orchestration lifecycle. Use repository plans
and behavior-level proof; do not create parallel control-plane state.
<!-- HARNESS:END -->

## Project

Two native apps for one product: `ios/` (Swift, SwiftUI) and `android/`
(Kotlin, Jetpack Compose). See `README.md` and `docs/README.md`.

- Validate with `scripts/validate.sh ios|android|all`; per-platform commands
  and known gaps are in `docs/runbooks/`.
- Product behavior shared by both apps belongs in `docs/product/`. Keep the two
  apps consistent with it; do not invent workout content, timings, or other
  product rules that are not written there.
- Android dependency versions live in `android/gradle/libs.versions.toml`.
  New Swift files under `ios/SevenMinWorkout/` join the target automatically;
  do not hand-edit `project.pbxproj` to add files.
