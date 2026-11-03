# Product Docs

This directory contains current consumer-product behavior derived from real
accepted intent. Harness deliberately ships no fake product domains.

When a user provides a product specification, derive smaller living documents
here instead of keeping one growing specification as the operating manual. Name
files after actual product domains, such as `overview.md`, `billing.md`,
`permissions.md`, or `api-conventions.md`.

## Current Product Contract

Draft awaiting owner approval (plan milestone M0). Documents are written in
Vietnamese; catalog JSON keys are English.

| Document | Domain |
| --- | --- |
| [overview.md](overview.md) | Product purpose, principles, v1 scope |
| [catalog.md](catalog.md) | Exercises, workouts, Smart Workout templates, catalog schema and checks |
| [workout-player.md](workout-player.md) | Session structure, timings, audio cues, controls, interruptions |
| [smart-workout.md](smart-workout.md) | Fitness levels, Smart Workout generation, feedback, level changes |
| [personal-data.md](personal-data.md) | Likes, custom workouts, history, backup, export, settings |
| [reminders.md](reminders.md) | Workout and inactivity reminders |
| [content.md](content.md) | 3D illustrations, AI voice, text, provenance |
| [catalog/](catalog/) | Shared catalog JSON read by both apps |

## Update Rule

When behavior changes:

1. Update the affected product document when the expected behavior changed.
2. Update the active execution plan when complex work uses one.
3. Add a lasting decision only when future work must inherit a consequential
   product, architecture, data, security, compatibility, or validation choice.
4. Add or update executable proof that exercises the behavior.

Bounded changes do not require a parallel lifecycle record.
