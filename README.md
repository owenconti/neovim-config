# neovim-config

My self-contained Neovim config. The repo *is* the Neovim config directory —
`init.lua` at the root bootstraps `lua/owen/`, and plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim) pinned via `lazy-lock.json`.

## Setup on a new machine

One-line bootstrap (installs deps + clones this config to `~/.config/nvim`):

```sh
curl -fsSL https://raw.githubusercontent.com/owenconti/neovim-config/main/install.sh | bash
nvim   # lazy.nvim, Mason, and treesitter self-provision on first run
```

Or clone first, then run the installer from the repo:

```sh
git clone https://github.com/owenconti/neovim-config.git ~/.config/nvim
~/.config/nvim/install.sh
nvim
```

`install.sh` is idempotent (safe to re-run) and macOS/Homebrew-oriented. It
installs `neovim`, `git`, `ripgrep`, `fd`, `lazygit`, `fzf`, `node`, `python3`,
the Xcode CLT (C compiler for treesitter), and a Nerd Font, then clones (or
pulls) this config to `~/.config/nvim`. PHP tooling is opt-in (uncomment in the
script).

### Manual setup

If you'd rather not run the script, install the deps listed above with your
package manager, then clone the repo straight into place:

```sh
git clone https://github.com/owenconti/neovim-config.git ~/.config/nvim
nvim
```

## Layout

```
init.lua            entry point — require('owen')
lua/owen/           all config modules (namespaced to avoid plugin collisions)
  init.lua          lazy.nvim bootstrap + module loading
lazy-lock.json      pinned plugin versions (lazy's default lockfile location)
```
