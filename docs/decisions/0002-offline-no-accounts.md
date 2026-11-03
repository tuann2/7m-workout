# 0002 Offline App Without Accounts

Date: 2026-11-03

## Status

Accepted

## Context

The app replaces J&J Official 7 Minute Workout, which was retired in 2024. The
retired app depended on its own backend for accounts, sync, history and
feedback, and told users that results, fitness level and exercise preferences
would not be saved while offline. The owner wants a free replacement that keeps
working without any server.

## Decision

- The app works fully offline. The Android app does not request the `INTERNET`
  permission. The iOS app contains no networking code.
- No accounts, no analytics, no crash reporting service, no advertising, no
  in-app purchases.
- User data stays on the device. It is protected by the operating system
  backup (Android Auto Backup, iCloud device backup) and by a JSON export and
  import file with the same format on both platforms.

## Alternatives Considered

1. Optional account with cloud sync: rejected; it recreates the server
   dependency that broke the retired app.
2. Analytics or crash reporting SDK: rejected; it needs network access and
   complicates the privacy promise.

## Consequences

Positive:

- The privacy promise is simple and checkable from the Android manifest.
- Nothing breaks when a service shuts down.

Tradeoffs:

- No automatic crash reports; problems come from GitHub issues.
- No in-app update check; users follow GitHub Releases or use Obtainium.
- Moving data between devices needs a manual export and import.

## Follow-Up

- Any future feature that needs network access requires a decision that
  supersedes this one.
