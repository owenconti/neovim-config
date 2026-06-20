# neovim-config

My self-contained Neovim config. The repo *is* the Neovim config directory —
`init.lua` at the root bootstraps `lua/owen/`, and plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim) pinned via `lazy-lock.json`.

## Setup on a new machine

```sh
git clone git@github.com:owenconti/neovim-config.git ~/development/nvim-config
ln -s ~/development/nvim-config ~/.config/nvim
nvim   # lazy.nvim bootstraps and installs everything from lazy-lock.json
```

Or skip the symlink and clone straight into place:

```sh
git clone git@github.com:owenconti/neovim-config.git ~/.config/nvim
nvim
```

## Layout

```
init.lua            entry point — require('owen')
lua/owen/           all config modules (namespaced to avoid plugin collisions)
  init.lua          lazy.nvim bootstrap + module loading
lazy-lock.json      pinned plugin versions (lazy's default lockfile location)
```
