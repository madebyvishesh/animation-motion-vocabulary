---
name: animation-motion-vocabulary
description: Recognize, clarify, and apply UI animation vocabulary when building or refining interfaces, websites, apps, games, prototypes, or design specs. Use when users mention or imply entrances/exits, sequencing/timing, movement/transforms, transitions between states, scroll motion, feedback/interaction, easing, springs, looping/ambient motion, polish/effects, animation performance, or motion principles. Triggers include fade, slide, scale, pop, reveal, keyframes, tween, stagger, transform origin, shared element transition, layout animation, scroll reveal, parallax, tap feedback, drag, ripple, ease-out, spring, bounce, marquee, shimmer, number ticker, jank, reduced motion, or vague phrases like "snappy", "smooth", "feels alive", "connected", "like iOS", "cascade the items", "numbers should roll", or "avoid jank".
---

# Animation Motion Vocabulary

## Overview

Use this skill to translate fuzzy motion requests into precise animation terms, ask clarifying questions only when needed, and implement motion that is purposeful, smooth, and accessible.

Core vocabulary source: Animation Vocabulary by Emil Kowalski at `https://animations.dev/vocabulary`. Preserve this attribution when sharing or adapting the skill.

Keep the detailed glossary in `references/animation-motion-vocabulary.md` as the source of truth. Load it when a task depends on exact terminology, when the user asks what a term means, or when you need to map a vague phrase to a motion pattern.

## Term Matching

When the user names a term exactly, use it directly and apply its meaning from the glossary. Skip the confirmation step and implement.

When the user describes an effect without naming it — including vague phrases like "snappy", "smooth", "cascade", "feels alive", "like iOS", "roll up", "avoid jank" — always do the following **before writing any code**:

1. Identify the closest animation term(s) from the glossary.
2. Reply with a structured confirmation block in this exact shape:

```
**Mapped to:** `<term>` [+ `<term2>` if multiple]
<one sentence explaining what this term means and why it fits>

**Refined prompt:** "<rewrite the user's request using the exact animation vocabulary, specific enough to implement>"

Is this what you meant? Or should I adjust it?
```

3. Wait for the user to confirm or correct before writing any code or making any changes.

This applies even when the mapping seems obvious. The goal is to surface your interpretation, teach the vocabulary, and give the user a precise prompt they can reuse or redirect.

**Examples of how to respond:**

User: "Make the cards cascade in"
```
**Mapped to:** `stagger`
Each card enters one after another with a small delay between them, creating a cascade effect.

**Refined prompt:** "Animate the cards with a stagger entrance — fade + slide up, ~60ms delay between each item."

Is this what you meant? Or should I adjust it?
```

User: "The modal should grow from the button"
```
**Mapped to:** `origin-aware animation`
The modal scales up from the button's position rather than from its own center, so it feels like it comes out of the trigger.

**Refined prompt:** "Animate the modal open with a scale-in that uses the trigger button's position as the transform-origin."

Is this what you meant? Or should I adjust it?
```

User: "It stutters when I scroll"
```
**Mapped to:** `jank` → likely `layout thrashing` or missing `compositing`
Stutter during scroll usually means the browser is recalculating layout every frame, or the animated element isn't on its own GPU layer.

**Refined prompt:** "Investigate scroll jank: check for layout-thrashing properties (width, height, top, left), ensure animated elements use transform/opacity only, and add will-change where appropriate."

Is this what you meant? Or should I adjust it?
```

When two terms would produce noticeably different results, name both and explain the difference before asking:

```
**Could be:** `shared element transition` or `crossfade`
- Shared element: the thumbnail physically travels and morphs into the detail card across the screen.
- Crossfade: the thumbnail fades out while the detail card fades in at its own position.

**Which did you mean?**
```

## Motion Selection

Choose motion by purpose:

- Orientation: use continuity transitions, shared element transitions, layout animation, direction-aware transitions, page/view transitions, or spatial consistency.
- Entrance and exit: use fade, slide, scale, pop, reveal, enter/exit, sequencing, and fill modes.
- Feedback: use hover effects, press/tap feedback, ripple, shake/wiggle, hold to confirm, drag response, or rubber-banding.
- Focus: use pulse, shimmer, number ticker, text morph, line drawing, or subtle blur/mask reveals.
- Depth: use parallax, perspective, 3D tilt/flip, transform origin, or origin-aware animation.
- Ambient life: use float, orbit, idle animation, loop, yoyo, or marquee only when it supports the product tone.
- Performance repair: favor transform and opacity, avoid layout-thrashing properties, use compositing carefully, and verify reduced motion support.

## Implementation Guidance

Prefer `transform` and `opacity` for high-frequency animation. Avoid animating `width`, `height`, `top`, `left`, or layout-heavy properties unless the framework supplies performant layout animation or the element count is tiny.

Use ease-out for user-triggered entrances and feedback. Use ease-in-out for objects already visible and moving between two states. Avoid linear easing for UI except spinners, marquees, and other constant-motion loops.

Use springs when the motion should feel physical, interruptible, draggable, or momentum-aware. Tune damping before adding more bounce; frequent UI motion should settle quickly and calmly.

Respect `prefers-reduced-motion`. Reduce distance, remove parallax/3D/looping motion, or switch to fades where appropriate.

For repeated or productivity UI, make animations shorter and subtler. For expressive marketing, onboarding, games, or playful product moments, richer motion is acceptable if it still serves orientation or feedback.

## Reference

Read `references/animation-motion-vocabulary.md` for:

- The full glossary grouped by category.
- Near-match phrase mappings.
- Term-to-implementation notes.
- Performance and accessibility principles.
