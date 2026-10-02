# askysh/homebrew-tap

Homebrew formula and cask for [BenchBar](https://github.com/askysh/benchbar):
local Frappe and ERPNext benches on macOS, set up, run and repaired from
the terminal or the menu bar.

```bash
brew install askysh/tap/benchbar askysh/tap/benchbar-app
benchbar install              # sets up the Mac, asks for sudo once
source ~/.zshrc && benchup
```

| Name | What | Where |
|---|---|---|
| `benchbar` (formula) | the `benchbar` command line tool | Apple silicon and Intel |
| `benchbar-app` (cask) | BenchBar.app, the menu bar app; installs the formula too | Apple silicon, macOS Sonoma or later |

Type both names: Homebrew trusts a third party tap only for the names on
the command line, so the cask alone would be refused its formula. For the
command line tool alone: `brew install askysh/tap/benchbar`.

## Updates

- The command line tool: `brew upgrade askysh/tap/benchbar`, or
  `benchbar self-update`, which runs it.
- The app updates itself. To force it through Homebrew:
  `brew upgrade --cask --greedy askysh/tap/benchbar-app`.

## Uninstall

```bash
benchbar uninstall-service --all     # brew uninstall cannot stop the background services
brew uninstall --cask benchbar-app
brew uninstall benchbar
```

The benches, their sites and `~/.local/state/benchbar` (logs, backups,
remembered benches) stay.

## How this tap is updated

Publishing a release of askysh/benchbar runs its `homebrew-tap.yml`
workflow: it renders `Formula/benchbar.rb` and, for a signed release,
`Casks/benchbar-app.rb`, installs and tests both, and opens a pull request
here that merges itself once the checks pass. Change the templates in
[packaging/homebrew](https://github.com/askysh/benchbar/tree/main/packaging/homebrew),
not the files here.

Frappe and ERPNext are trademarks of Frappe Technologies. BenchBar is not
affiliated with or endorsed by them.
