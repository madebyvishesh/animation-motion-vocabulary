# Animation Motion Vocabulary Skill

An installable agent skill that maps plain-language motion requests to precise animation terms — and confirms what it understood before writing any code.

You say: `"make the cards cascade in"`
Agent replies:

```
**Mapped to:** `stagger`
Each card enters one after another with a small delay, creating a cascade.

**Refined prompt:** "Animate the cards with a stagger entrance — fade + slide up, ~60ms delay between each item."

Is this what you meant? Or should I adjust it?
```

Vocabulary source: [Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_).

---

## Install

Run in your terminal — not in the agent chat.

**macOS / Linux / WSL**

```bash
# Claude Code
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- claude

# Codex
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- codex

# Both
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- all
```

**Windows (PowerShell)**

```powershell
# Claude Code
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) claude"

# Codex
powershell -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.ps1'))) codex"
```

> If you get a TLS error on older Windows, prepend: `[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072;`

Start a new agent session after installing.

---

## Use

Just describe the motion you want — the skill triggers automatically:

```
Make the pricing cards appear one by one as I scroll.
```

Or call it explicitly:

```
/animation-motion-vocabulary  make this feel more alive
```

**Other modes:**

- **Identify** — `"What's this animation called?"` — points at code, names the term
- **Audit** — `"Check my animations for performance issues"` — flags jank, bad easing, missing reduced motion

---

## Update

```bash
curl -fsSL https://raw.githubusercontent.com/madebyvishesh/animation-motion-vocabulary/refs/heads/main/install.sh | bash -s -- claude
```

Rerun the same install command you used originally.

---

## Credit

[Animation Vocabulary](https://animations.dev/vocabulary) by [Emil Kowalski](https://x.com/emilkowalski_). See [NOTICE.md](NOTICE.md).

## License

MIT — see [LICENSE](LICENSE).
