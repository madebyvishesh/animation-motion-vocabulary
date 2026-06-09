# Animation Motion Vocabulary Skill

An installable agent skill for UI animation language.

It helps coding agents understand requests like:

- "make it feel snappy"
- "make the cards cascade in"
- "open this from the button"
- "make the number roll up"
- "this animation feels laggy"

Instead of guessing, the agent can map those phrases to motion terms like `stagger`, `spring`, `ease-out`, `origin-aware animation`, `shared element transition`, `scroll reveal`, `number ticker`, `shimmer`, or `jank`.

The core vocabulary comes from [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_). This repo packages it as a portable `SKILL.md` folder and adds agent-specific guidance for fuzzy matching, clarification, and implementation.

## Install

Codex:

```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- codex
```

Claude Code:

```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- claude
```

Both:

```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- all
```

Custom skills directory:

```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/main/install.sh | bash -s -- custom /path/to/skills
```

The installer copies the skill folder into the selected skills directory. It does not add shell config, install packages, or run any skill code.

## Manual Install

Clone the repo:

```bash
git clone https://github.com/madebyvishesh/animation-motion-vocabulary.git
cd animation-motion-vocabulary
```

Then install locally:

```bash
./install.sh codex
./install.sh claude
./install.sh all
```

Or copy the folder yourself:

```bash
mkdir -p ~/.codex/skills
cp -R animation-motion-vocabulary ~/.codex/skills/
```

For Claude Code personal skills:

```bash
mkdir -p ~/.claude/skills
cp -R animation-motion-vocabulary ~/.claude/skills/
```

For Claude Code project skills:

```bash
mkdir -p .claude/skills
cp -R animation-motion-vocabulary .claude/skills/
```

After installing, start a new agent session if the skill does not show up immediately.

## Where It Installs

| Agent | Install path |
| --- | --- |
| Codex | `~/.codex/skills/animation-motion-vocabulary/` |
| Claude Code, personal | `~/.claude/skills/animation-motion-vocabulary/` |
| Claude Code, project | `.claude/skills/animation-motion-vocabulary/` |
| Other agents | Wherever that agent loads `SKILL.md` folders |

The important part is that the final path contains:

```text
animation-motion-vocabulary/SKILL.md
```

Claude Code documents personal and project skills here: <https://code.claude.com/docs/en/skills>

## How To Use It

You can call it directly:

```text
Use $animation-motion-vocabulary to make this interface motion feel smoother and more intentional.
```

You can also just describe the motion you want:

```text
Make the pricing cards appear one by one as I scroll.
```

The skill tells the agent to recognize that as:

- `stagger`: one item after another
- `scroll reveal`: animation triggered as items enter the viewport

More examples:

| User phrase | Likely animation term |
| --- | --- |
| "Make it feel snappy" | `ease-out` or a well-damped `spring` |
| "Make the list cascade in" | `stagger` |
| "The modal should grow from the button" | `origin-aware animation` |
| "The product image should open into the detail page" | `shared element transition` |
| "Make the button feel pressed" | `press / tap feedback` |
| "Make the background move slower on scroll" | `parallax` |
| "Make the number roll up" | `number ticker` with `tabular numbers` |
| "Add that loading shine" | `skeleton / shimmer` |
| "It stutters when I scroll" | `jank`, `dropped frames`, or `layout thrashing` |
| "Make it feel like iOS overscroll" | `rubber-banding` |

When a request could mean two different things, the skill nudges the agent to ask a tight clarification:

```text
That sounds like a shared element transition: the same item travels and transforms between states. Is that what you mean, or do you want a simpler crossfade?
```

## What The Skill Teaches

The vocabulary covers:

- Entrances and exits: fade, slide, scale, pop, reveal
- Sequencing and timing: keyframes, tweening, stagger, orchestration, duration
- Movement and transforms: translate, scale, rotate, skew, perspective, transform origin
- Transitions between states: crossfade, morph, shared element transition, layout animation
- Scroll motion: scroll reveal, scroll-driven animation, parallax, page and view transitions
- Interaction feedback: hover, tap feedback, hold to confirm, drag, swipe, ripple, shake
- Easing and springs: ease-out, cubic-bezier, stiffness, damping, mass, bounce, momentum
- Ambient motion and effects: marquee, loop, yoyo, pulse, float, shimmer, ticker, typewriter
- Performance language: FPS, jank, dropped frames, compositing, `will-change`, layout thrashing
- Motion principles: purposeful animation, anticipation, follow-through, spatial consistency, reduced motion

It also gives implementation preferences: use `transform` and `opacity` where possible, avoid layout-heavy animation for repeated motion, and respect `prefers-reduced-motion`.

## Files

```text
.
├── README.md
├── LICENSE
├── NOTICE.md
├── install.sh
├── animation-motion-vocabulary.md
└── animation-motion-vocabulary/
    ├── SKILL.md
    ├── agents/
    │   └── openai.yaml
    └── references/
        └── animation-motion-vocabulary.md
```

`animation-motion-vocabulary/SKILL.md` is the entry point agents load.

`animation-motion-vocabulary/references/animation-motion-vocabulary.md` is the longer glossary the agent can read when it needs detail.

`animation-motion-vocabulary.md` is a standalone Markdown version for humans.

`agents/openai.yaml` is optional Codex UI metadata.

## Updating

Pull the latest repo and run the installer again:

```bash
git pull
./install.sh codex
```

For the curl install path, rerun the same command you used originally.

## Security

This is an instruction-only skill. There are no skill scripts, package installs, network calls, or hidden runtime dependencies.

Still, read any skill before installing it. Skills shape how an agent behaves, and future forks may add scripts or permissions.

## Credit

Original vocabulary: [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_).

This repository adapts that vocabulary into a portable agent skill with install instructions, fuzzy phrase matching, and implementation guidance.

Please keep the attribution when sharing or adapting the skill.

## License

MIT for this repository's packaging, installer, and added skill guidance. The original vocabulary is credited above and in [NOTICE.md](NOTICE.md).
