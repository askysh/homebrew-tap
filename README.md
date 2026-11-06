# askysh/homebrew-tap

The Homebrew tap for two macOS apps:

- [Margin](https://github.com/askysh/margin): a meeting notepad with local
  transcription, speaker names and plain Markdown notes.
- [BenchBar](https://benchbar.akashmishra.com/): local Frappe and ERPNext
  benches, set up, run and repaired from the terminal or the menu bar.

| Name | Kind | What it installs | Where |
|---|---|---|---|
| `margin` | cask | Margin.app | Apple silicon, macOS Sonoma or later |
| `benchbar` | formula | the `benchbar` command line tool | Apple silicon and Intel |
| `benchbar-app` | cask | BenchBar.app, the menu bar app. It needs the `benchbar` formula. | Apple silicon, macOS Sonoma or later |

## Margin

### Install

```bash
brew install --cask askysh/tap/margin
```

Margin needs macOS 14.4 or later to record calls.

### Updates

Margin updates itself (Settings → Updates). To force an update through Homebrew:

```bash
brew upgrade --cask --greedy askysh/tap/margin
```

### Uninstall

```bash
brew uninstall --cask margin
```

This removes the app. Add `--zap` to also remove its settings and models.
Your meetings stay in the folder you chose, also after `--zap`.

## BenchBar

### Install

```bash
brew install askysh/tap/benchbar askysh/tap/benchbar-app
benchbar install              # sets up the Mac, asks for sudo once
source ~/.zshrc && benchup
```

Type both names. Homebrew trusts a third party tap only for the names on
the command line. With the cask name alone, it refuses the formula that
the cask needs. For the command line tool alone:
`brew install askysh/tap/benchbar`.

### Updates

- The command line tool: `brew upgrade askysh/tap/benchbar`, or
  `benchbar self-update`, which runs it.
- The app updates itself. To force an update through Homebrew:
  `brew upgrade --cask --greedy askysh/tap/benchbar-app`.

### Uninstall

```bash
benchbar uninstall-service --all     # brew uninstall cannot stop the background services
brew uninstall --cask benchbar-app
brew uninstall benchbar
```

The benches, their sites and `~/.local/state/benchbar` (logs, backups,
remembered benches) stay.

## How this tap is updated

Each app has a `homebrew-tap.yml` workflow. It starts when a release of the
app is published. It renders the app's files from templates, audits,
installs and tests them, then opens a pull request here. The pull request
merges itself after the `tests` check passes.

| App | Files here | Templates |
|---|---|---|
| Margin | `Casks/margin.rb` | [askysh/margin: packaging/homebrew](https://github.com/askysh/margin/tree/main/packaging/homebrew) |
| BenchBar | `Formula/benchbar.rb`, and `Casks/benchbar-app.rb` for a signed release | [askysh/benchbar: packaging/homebrew](https://github.com/askysh/benchbar/tree/main/packaging/homebrew) |

Change the templates, not the files here.

The `tests` check ([tests.yml](.github/workflows/tests.yml)) runs
`brew style` on the whole tap. On a pull request that changes formulae or
casks, it audits (livecheck included), installs and uninstalls only those
files. Thus a release of one app does not wait for a release of the other.
On `main`, it checks all files without livecheck. A version older than the
latest release gives a warning, not a failure.

## Links

- Margin: [source](https://github.com/askysh/margin),
  [releases](https://github.com/askysh/margin/releases)
- BenchBar: [website](https://benchbar.akashmishra.com/),
  [source](https://github.com/askysh/benchbar),
  [releases](https://github.com/askysh/benchbar/releases)

Frappe and ERPNext are trademarks of Frappe Technologies. BenchBar is not
affiliated with or endorsed by them.
