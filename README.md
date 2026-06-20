# neovim-config

My self-contained Neovim config. The repo *is* the Neovim config directory —
`init.lua` at the root bootstraps `lua/owen/`, and plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim) pinned via `lazy-lock.json`.

## Setup on a new machine

```sh
git clone git@github.com:owenconti/neovim-config.git ~/development/nvim-config
cd ~/development/nvim-config
./install.sh   # installs deps (Homebrew) + symlinks this repo to ~/.config/nvim
nvim           # lazy.nvim, Mason, and treesitter self-provision on first run
```

`install.sh` is idempotent (safe to re-run) and macOS/Homebrew-oriented. It
installs `neovim`, `git`, `ripgrep`, `fd`, `lazygit`, `fzf`, `node`, `python3`,
the Xcode CLT (C compiler for treesitter), and a Nerd Font — then links the
config. PHP tooling is opt-in (uncomment in the script).

### Manual setup

If you'd rather not run the script, install the deps listed above with your
package manager, then link the repo:

```sh
ln -s ~/development/nvim-config ~/.config/nvim   # or clone straight into ~/.config/nvim
nvim
```

## Layout

```
init.lua            entry point — require('owen')
lua/owen/           all config modules (namespaced to avoid plugin collisions)
  init.lua          lazy.nvim bootstrap + module loading
lazy-lock.json      pinned plugin versions (lazy's default lockfile location)
```
