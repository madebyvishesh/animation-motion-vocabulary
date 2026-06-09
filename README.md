# Animation Motion Vocabulary Skill

An installable agent skill for UI animation language.

You describe motion in plain words:

- "make it feel snappy"
- "make the cards cascade in"
- "open this from the button"
- "make the number roll up"
- "this animation feels laggy"

The agent maps those phrases to precise animation terms, shows you exactly what it understood, and confirms with you before writing any code.

The core vocabulary comes from [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_). This repo packages it as a portable `SKILL.md` folder and adds agent-specific guidance for phrase matching, confirmation, and implementation.

## What to expect

When you describe motion in plain words, the agent replies with a confirmation block before doing anything:

```
**Mapped to:** `stagger`
Each card enters one after another with a small delay between them, creating a cascade effect.

**Refined prompt:** "Animate the cards with a stagger entrance — fade + slide up, ~60ms delay between each item."

Is this what you meant? Or should I adjust it?
```

You confirm, correct, or redirect — then it implements. No code is written until you agree on what the animation actually is.

When a phrase could mean two meaningfully different things, it names both and explains the difference:

```
**Could be:** `shared element transition` or `crossfade`
- Shared element: the thumbnail physically travels and morphs into the detail card.
- Crossfade: the thumbnail fades out while the detail card fades in at its own position.

Which did you mean?
```

## Install

> Run these commands in your terminal. Do not paste them into the agent chat.

### macOS / Linux / WSL / Git Bash

**Claude Code:**
```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- claude
```

**Codex:**
```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- codex
```

**Both at once:**
```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- all
```

**Custom skills directory:**
```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- custom /path/to/skills
```

### Windows (PowerShell)

**Claude Code:**
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) claude"
```

**Codex:**
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) codex"
```

**Both at once:**
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) all"
```

The installer copies the skill folder into the selected skills directory. It does not touch shell config, install packages, or run any skill code.

On Windows, `~` maps to your user profile (`%USERPROFILE%`).

> **TLS note for older Windows:** If the PowerShell command fails with a TLS or SSL error, your system may default to an older TLS version. Prepend the fix:
> ```powershell
> powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072; & ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) claude"
> ```
> PowerShell 7 (`pwsh`) users can use the same commands — replace `powershell` with `pwsh`.

## Where it installs

| Agent | Path |
| --- | --- |
| Claude Code — personal | `~/.claude/skills/animation-motion-vocabulary/` |
| Claude Code — project | `.claude/skills/animation-motion-vocabulary/` |
| Codex | `~/.codex/skills/animation-motion-vocabulary/` |
| Other agents | Wherever that agent loads `SKILL.md` folders |

The critical file is:

```
animation-motion-vocabulary/SKILL.md
```

Claude Code skills documentation: <https://code.claude.com/docs/en/skills>

## How to use it

The skill works in three modes depending on what you say.

### Describe mode (most common)

Describe the motion you want in plain words. The skill triggers automatically:

```
Make the pricing cards appear one by one as I scroll.
```

The agent maps that to `stagger` + `scroll reveal`, shows you the refined prompt, and waits for your confirmation. When you say "yes" or "go ahead", it implements.

You can also call it explicitly to make sure it activates:

```
/animation-motion-vocabulary  make this feel more alive
```

### Identify mode

Point at existing code or a running animation and ask what it is:

```
What's this animation called? [pastes code]
```

```
I see items fading in one by one — what technique is this?
```

The agent names the term and explains it.

### Audit mode

Ask it to review your existing animations for problems:

```
Audit my animations — are there any performance issues?
```

```
Check this component's motion. Does anything feel off?
```

It scans for jank-causing properties, bad easing choices, missing `prefers-reduced-motion`, and timing issues — and reports findings by severity.

---

**Phrase → term quick reference:**

| What you say | What it maps to |
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

## What the skill teaches

- **Entrances and exits:** fade, slide, scale, pop, reveal
- **Sequencing and timing:** keyframes, tween, stagger, orchestration, duration
- **Movement and transforms:** translate, scale, rotate, skew, perspective, transform origin
- **State transitions:** crossfade, morph, shared element transition, layout animation
- **Scroll motion:** scroll reveal, scroll-driven animation, parallax, page and view transitions
- **Interaction feedback:** hover, tap feedback, hold to confirm, drag, swipe, ripple, shake
- **Easing and springs:** ease-out, cubic-bezier, stiffness, damping, mass, bounce, momentum
- **Ambient motion:** marquee, loop, yoyo, pulse, float, shimmer, ticker, typewriter
- **Performance:** FPS, jank, dropped frames, compositing, `will-change`, layout thrashing
- **Motion principles:** purposeful animation, anticipation, follow-through, spatial consistency, reduced motion

Implementation preferences: use `transform` and `opacity` for animated properties, avoid layout-heavy animation for repeated motion, and respect `prefers-reduced-motion`.

## Manual install

Clone and run the installer locally:

```bash
git clone https://github.com/madebyvishesh/animation-motion-vocabulary.git
cd animation-motion-vocabulary
./install.sh claude   # or codex, or all
```

On Windows:
```powershell
.\install.ps1 claude
```

Or copy the folder yourself:

```bash
# Claude Code — personal
mkdir -p ~/.claude/skills
cp -R animation-motion-vocabulary ~/.claude/skills/

# Claude Code — project (run from your project root)
mkdir -p .claude/skills
cp -R animation-motion-vocabulary .claude/skills/

# Codex
mkdir -p ~/.codex/skills
cp -R animation-motion-vocabulary ~/.codex/skills/
```

After installing, start a new agent session if the skill does not show up immediately.

## Updating

Pull the latest and run the installer again:

```bash
git pull
./install.sh claude
```

For curl installs, rerun the same command you used originally.

## Files

```text
.
├── README.md
├── LICENSE
├── NOTICE.md
├── CONTRIBUTING.md
├── SECURITY.md
├── install.sh
├── install.ps1
├── GLOSSARY.md                           ← human-readable vocabulary reference
└── animation-motion-vocabulary/          ← the skill folder agents load
    ├── SKILL.md                          ← agent entry point
    ├── agents/
    │   └── openai.yaml                   ← optional Codex UI metadata
    └── references/
        └── animation-motion-vocabulary.md ← full glossary the agent reads
```

## Security

This is an instruction-only skill. There are no skill scripts, package installs, network calls, or hidden runtime dependencies.

Read any skill before installing it. Skills shape how an agent behaves, and future forks may add scripts or permissions.

## Credit

Original vocabulary: [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_).

This repository adapts that vocabulary into a portable agent skill with install instructions, phrase matching, confirm-first behavior, and implementation guidance.

Please keep the attribution when sharing or adapting the skill.

## License

MIT for this repository's packaging, installer, and added skill guidance. The original vocabulary is credited above and in [NOTICE.md](NOTICE.md).
