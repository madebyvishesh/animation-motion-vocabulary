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

When the user names a term, use that term directly and apply its meaning from the glossary.

When the user describes an effect without naming it:

1. Infer the closest term if the intent is clear.
2. Briefly name the term back to the user before or while implementing it.
3. Ask for confirmation only when two or more terms would produce noticeably different behavior.

Use this confirmation shape when needed:

```text
That sounds like a shared element transition: the same item travels and transforms between states. Is that what you mean, or do you want a simpler crossfade?
```

Do not interrupt implementation for obvious mappings. For example:

- "Make cards appear as I scroll" -> scroll reveal.
- "Make the list items come in one by one" -> stagger.
- "Make it appear with a little bounce" -> pop in or spring bounce.
- "The modal should grow from the button" -> origin-aware animation with transform-origin set near the trigger.
- "The product image should open into the details page" -> shared element transition.
- "Make the button feel pressed" -> press/tap feedback.
- "This should feel snappy, not robotic" -> ease-out or spring with higher stiffness and enough damping.
- "The number should roll up" -> number ticker with tabular numbers.
- "The list should rearrange smoothly" -> drag to reorder plus layout animation.
- "It stutters" or "feels laggy" -> investigate jank, layout thrashing, compositing, and animated properties.

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
