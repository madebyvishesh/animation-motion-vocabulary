# Animation Motion Vocabulary Skill

A portable `SKILL.md` package that helps AI coding agents understand, suggest, and apply common UI animation vocabulary.

This skill packages and adapts the animation vocabulary by **Emil Kowalski** from **animations.dev**.

Original source: <https://animations.dev/vocabulary>

Use it when you want an agent to turn fuzzy motion feedback like "make it feel snappy", "make the cards cascade in", "make this open from the button", or "the animation feels laggy" into precise terms such as `stagger`, `origin-aware animation`, `spring`, `ease-out`, `shared element transition`, `scroll reveal`, `number ticker`, or `jank`.

## What This Is

This repository contains:

- `animation-motion-vocabulary/SKILL.md`: the installable skill entry point.
- `animation-motion-vocabulary/references/animation-motion-vocabulary.md`: the full vocabulary reference the agent loads when needed.
- `animation-motion-vocabulary/agents/openai.yaml`: optional Codex UI metadata.
- `animation-motion-vocabulary.md`: standalone human-readable Markdown glossary.
- `install.sh`: helper script for copying the skill into supported local skill directories.

The skill is intentionally text-only. It has no runtime dependencies and does not execute code.

## Credit

The core vocabulary is based on [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_). This repository turns that vocabulary into an installable agent skill and adds agent-specific usage guidance, fuzzy term matching, install instructions, and packaging.

Please keep this attribution when sharing, forking, or adapting the skill.

## What It Helps Agents Do

- Recognize animation terms the user mentions directly.
- Infer likely terms from near-matching natural language.
- Ask a short confirmation question when two animation terms could fit.
- Choose motion patterns by purpose: orientation, feedback, entrance/exit, focus, depth, ambient motion, or performance repair.
- Prefer smooth and accessible implementation guidance, including `transform`, `opacity`, and `prefers-reduced-motion`.

## Supported Agents

This package follows the common skill-folder pattern: a directory containing a `SKILL.md` file plus optional supporting files.

Known local install targets:

| Agent | Personal install path | Project install path |
| --- | --- | --- |
| Codex | `~/.codex/skills/animation-motion-vocabulary/` | Depends on the Codex environment |
| Claude Code | `~/.claude/skills/animation-motion-vocabulary/` | `.claude/skills/animation-motion-vocabulary/` |

For Claude Code, Anthropic documents personal skills at `~/.claude/skills/<skill-name>/SKILL.md` and project skills at `.claude/skills/<skill-name>/SKILL.md`. See the official Claude Code skills docs: <https://code.claude.com/docs/en/skills>

For other agents, install the `animation-motion-vocabulary/` folder wherever that agent expects skill directories. The important requirement is that the final path contains:

```text
animation-motion-vocabulary/SKILL.md
```

## Install

Clone the repository:

```bash
git clone https://github.com/madebyvishesh/animation-motion-vocabulary.git
cd animation-motion-vocabulary
```

Install for Codex:

```bash
./install.sh codex
```

Install for Claude Code:

```bash
./install.sh claude
```

Install for both:

```bash
./install.sh all
```

Install into a custom directory:

```bash
./install.sh custom /path/to/skills
```

That creates:

```text
/path/to/skills/animation-motion-vocabulary/SKILL.md
```

## Manual Install

Copy the whole skill folder into your agent's skills directory.

For Codex:

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

After installing, restart the agent or start a new session if it does not pick up new skills live.

## Usage

Invoke it explicitly:

```text
Use $animation-motion-vocabulary to make this dashboard motion feel smoother and more intentional.
```

Or describe the desired effect naturally:

```text
Make the pricing cards appear one by one as I scroll.
```

The agent should map that to:

- `stagger`: one by one
- `scroll reveal`: as elements enter the viewport

More examples:

| User phrase | Likely term |
| --- | --- |
| "Make this feel snappy" | `ease-out` or a well-damped `spring` |
| "The modal should grow from the button" | `origin-aware animation` |
| "The image should open into the detail page" | `shared element transition` |
| "Make the button feel pressed" | `press / tap feedback` |
| "The number should roll up" | `number ticker` with `tabular numbers` |
| "The loading card needs that shiny placeholder" | `skeleton / shimmer` |
| "It stutters when I scroll" | `jank`, `dropped frames`, or `layout thrashing` |
| "Make it feel like iOS overscroll" | `rubber-banding` |

When the prompt is ambiguous, the skill tells the agent to confirm:

```text
That sounds like a shared element transition: the same item travels and transforms between states. Is that what you mean, or do you want a simpler crossfade?
```

## Repository Layout

```text
.
├── README.md
├── LICENSE
├── install.sh
├── animation-motion-vocabulary.md
└── animation-motion-vocabulary/
    ├── SKILL.md
    ├── agents/
    │   └── openai.yaml
    └── references/
        └── animation-motion-vocabulary.md
```

## Updating The Skill

Edit:

```text
animation-motion-vocabulary/SKILL.md
animation-motion-vocabulary/references/animation-motion-vocabulary.md
```

Keep `SKILL.md` concise. Put detailed vocabulary, examples, and mappings in the reference file so agents only load the larger glossary when needed.

If you update the vocabulary, also update the standalone glossary:

```text
animation-motion-vocabulary.md
```

## Security

This skill is instruction-only and contains no executable skill scripts. Still, review any third-party skill before installing it, especially if a future version adds scripts, dependencies, or tool permissions.

## License

MIT for the repository packaging, installer, and added skill guidance. The original vocabulary is credited above to Emil Kowalski and animations.dev. See [LICENSE](LICENSE).
