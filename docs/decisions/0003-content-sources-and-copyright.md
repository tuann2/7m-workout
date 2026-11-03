# 0003 Content Sources And Copyright

Date: 2026-11-03

## Status

Accepted

## Context

The owner analysed the retired app's final XAPK (version 2.8.5) to understand
its features. That package contains Johnson & Johnson's videos, voice audio,
texts and code. The replacement must look and work like the original without
reusing any of it, and the repository is public.

## Decision

- No Johnson & Johnson asset is used: no video, audio, image or voice of the
  original trainer, no brand names, logos or visual identity, no workout
  descriptions, motivational lines or articles, no decompiled code.
- The XAPK file is never committed to Git, including history.
- Functional facts are reused: which exercises exist, their muscle group,
  difficulty and one-sided flag, the order of exercises, cycles and rest of the
  22 workouts, and the easy/moderate/hard counts of the Smart Workout templates.
  Workout names and descriptions and all Vietnamese names are newly written;
  names invented by J&J are replaced.
- The 7 Minute Workout method is credited to Klika and Jordan, ACSM's Health &
  Fitness Journal, 2013.
- Exercise illustrations are loop videos of an original, realistic-looking male
  3D character made in Blender with scripts. The character source is chosen by
  the 3D spike.
- Voice prompts are pre-generated audio files from an AI voice service chosen
  by a listening test.
- Every media file carries provenance in the catalog (source, license, tool,
  date). Licenses must allow redistribution in a public Apache 2.0 repository.
  Assets whose license forbids redistribution stay out of the repository; only
  rendered output is committed.

## Alternatives Considered

1. AI-generated video (for example Kling): rejected as the main path because
   form errors and character drift need review clip by clip and terms differ
   by provider. Kept as an option for making the 3D renders look more real.
2. Filming a real person: needs a performer, a consistent set and model
   releases.
3. Device text-to-speech as the main voice: Vietnamese voices are missing on
   some Android devices.

## Consequences

Positive:

- Consistent character and exact loops; clips can be re-rendered at any time.
- No per-clip generation cost.

Tradeoffs:

- A scripted 3D character may look less real than filmed or AI video.
- Motion for 72 exercises must be authored or captured.

## Follow-Up

- Record the chosen character source and its license after the 3D spike.
- Record the chosen voice service and its terms after the listening test.
