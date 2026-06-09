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

If the user replies with "yes", "go", "do it", "go ahead", "that's right", "correct", "sounds good", or any clear confirmation, proceed directly to implementation — do not repeat the confirmation block.

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

## Reverse Lookup

When the user points at existing code or a running animation and asks what it is called ("what is this animation?", "what technique is this?", "what's this called?"), identify the closest term from the glossary and explain it briefly.

Reply shape:

```
**This is:** `<term>`
<one sentence explaining what defines this technique and why it fits what you're looking at>
```

Example:

User: "What's this called?" (points at items fading in one after another)
```
**This is:** `stagger`
Items are animated sequentially with a small delay between each one, creating the cascade effect you see.
```

## Animation Audit

When the user asks to review, check, or audit their animations ("check my animations", "audit this", "what's wrong with my motion?", "is this performant?"), scan the code and report findings in three tiers:

**Critical — causes jank or dropped frames:**
- Properties being animated other than `transform` and `opacity` (width, height, top, left, margin, padding, border-radius on large elements). Flag each and suggest the `transform` equivalent.
- Animating the same property in a loop at high frequency without `will-change`.

**Moderate — feels off to users:**
- `linear` easing on UI elements that are not spinners, progress bars, or marquees.
- `ease-in` on entrances — starts slow, feels sluggish.
- Exit animations that are longer than entrance animations (exits should be snappier).
- Durations over 400ms on frequently repeated elements (tooltips, dropdowns, hover states).
- Looping ambient motion (float, pulse, marquee) without a `prefers-reduced-motion` fallback.

**Polish — noticeable if you know what to look for:**
- Missing `prefers-reduced-motion` handling anywhere motion is non-trivial.
- Stagger delays that are too long (over 80ms per item) on lists with more than 6 items — the last item takes too long to arrive.
- Springs with very low damping on productivity UI — bouncy feels wrong in tools.

Format the output as a prioritised checklist. Only report tiers that have findings.

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

Duration reference:

| Animation type | Range |
| --- | --- |
| Micro-feedback (button press, hover, ripple) | 80–150ms |
| Entrance (modal, dropdown, tooltip appearing) | 150–300ms |
| Exit (same elements disappearing) | 100–200ms — exits should feel snappier than entrances |
| State transition (tab switch, accordion, crossfade) | 200–350ms |
| Page / route transition | 250–400ms |
| Emphasis (shake, pulse, draw attention) | 300–500ms |
| Ambient / looping (float, marquee, orbit) | 1500ms+ — slow enough to feel calm |

When in doubt, go shorter. Users notice slow more than fast.

## Framework Hints

When the project stack is identifiable, suggest the right tool:

- **React**: Framer Motion for layout animation, shared element transitions, gesture-driven motion, and springs. CSS transitions for simple hover/focus states. React Spring as an alternative when only springs are needed.
- **Vue**: `@vueuse/motion` or Vue's built-in `<Transition>` and `<TransitionGroup>`. TransitionGroup handles list stagger well.
- **Plain HTML/CSS**: CSS `@keyframes` and `transition` for most cases. Web Animations API (WAAPI) when you need JS control. View Transitions API for page and shared element transitions in supported browsers.
- **React Native**: Reanimated 3 for gesture-driven motion, layout animation, and anything needing the UI thread. The built-in `Animated` API for simple, non-gesture cases.
- **Svelte**: Built-in `transition:` and `animate:` directives handle most cases. `svelte/motion` tweened and spring stores for values.

If the stack is unknown, give framework-agnostic guidance using CSS property names and motion terms. Do not assume a library.

## Reference

Read `references/animation-motion-vocabulary.md` for:

- The full glossary grouped by category.
- Near-match phrase mappings.
- Term-to-implementation notes.
- Performance and accessibility principles.
