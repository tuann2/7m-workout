# 0005 Public Repository And GitHub Releases

Date: 2026-11-03

## Status

Accepted

## Context

The owner wants to ship before setting up Google Play and Apple developer
accounts, and chose to publish the source code.

## Decision

- The repository is public at `github.com/tuann2/7m-workout` under the Apache
  License 2.0.
- v1 is released through GitHub Releases. Android is the official v1 platform:
  each release attaches an APK signed with a self-managed keystore and its
  SHA-256 checksum.
- iOS ships as build-from-source instructions for Xcode until an Apple
  developer account exists. An unsigned IPA for AltStore or SideStore is
  optional.
- The release is built and uploaded by a script on the owner's machine with
  `gh release create`. Moving signing into GitHub Actions needs separate
  approval because the key would live in GitHub Secrets.
- The keystore never enters the repository and is backed up in two places.
  `versionCode` increases with every release.

## Alternatives Considered

1. Google Play and App Store first: blocked on accounts, closed testing and
   review.
2. Private repository: limits who can download releases and makes macOS CI
   minutes more expensive.

## Consequences

Positive:

- Users can install without a store account.
- Anyone can audit the privacy promise in the source.

Tradeoffs:

- Android users must allow installs from unknown sources and update manually
  or with Obtainium.
- iOS is practical only for the owner and technical users until an Apple
  account exists.
- Every file in the repository is public, so licensing of media matters
  ([decision 0003](0003-content-sources-and-copyright.md)).

## Follow-Up

- Register for Android developer verification before its global rollout in
  2027.
- When moving to Google Play, enrol in Play App Signing with the existing key
  so GitHub users can update through Play.
