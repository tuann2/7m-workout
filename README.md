# 7min Workout

Mobile app for iOS and Android, built as two native apps in one repository
(see [decision 0001](docs/decisions/0001-native-ios-and-android-apps.md)).

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

## Harness maintenance

`scripts/bin/harness` is downloaded by the installer and not committed. After a
fresh clone, reinstall it in merge mode (keeps every existing file):

```bash
curl -fsSL "https://raw.githubusercontent.com/hoangnb24/repository-harness/main/scripts/install-harness.sh?$(date +%s)" |
  bash -s -- --merge --claude --yes
scripts/bin/harness status
scripts/bin/harness update --dry-run
```
