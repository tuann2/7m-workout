# 7M Workout Nt0

Free, offline bodyweight workout app for iOS and Android, built as a
replacement for the retired J&J Official 7 Minute Workout app. Two native apps
live in one repository
(see [decision 0001](docs/decisions/0001-native-ios-and-android-apps.md)).
No accounts, no analytics, no ads
([decision 0002](docs/decisions/0002-offline-no-accounts.md)).

This project is not affiliated with or endorsed by Johnson & Johnson. It uses
none of the original app's videos, audio, texts or code
([decision 0003](docs/decisions/0003-content-sources-and-copyright.md)).

Status: in development. Product spec: [docs/product/](docs/product/README.md).
Plan: [docs/plans/active/7m-workout-nt0-v1.md](docs/plans/active/7m-workout-nt0-v1.md).

## Layout

| Path | Contents |
| --- | --- |
| `ios/` | SwiftUI app — Xcode project `SevenMinWorkout.xcodeproj`, scheme `SevenMinWorkout` |
| `android/` | Kotlin + Jetpack Compose app — Gradle project, module `:app` |
| `docs/` | Product intent, decisions, runbooks, plans ([map](docs/README.md)) |
| `scripts/validate.sh` | Build and test both apps |
| `AGENTS.md`, `CLAUDE.md` | Instructions for coding agents ([repository-harness](https://github.com/hoangnb24/repository-harness)) |

## Quick start

```bash
scripts/validate.sh            # iOS + Android
scripts/validate.sh ios        # iOS only
scripts/validate.sh android    # Android only
```

- iOS: open `ios/SevenMinWorkout.xcodeproj` in Xcode — [runbook](docs/runbooks/ios.md)
- Android: open `android/` in Android Studio — [runbook](docs/runbooks/android.md)

## License

Apache License 2.0, see [LICENSE](LICENSE). Exercise method: Klika B., Jordan C.,
"High-intensity circuit training using body weight", ACSM's Health & Fitness
Journal, 2013.

## Harness maintenance

`scripts/bin/harness` is downloaded by the installer and not committed. After a
fresh clone, reinstall it in merge mode (keeps every existing file):

```bash
curl -fsSL "https://raw.githubusercontent.com/hoangnb24/repository-harness/main/scripts/install-harness.sh?$(date +%s)" |
  bash -s -- --merge --claude --yes
scripts/bin/harness status
scripts/bin/harness update --dry-run
```
