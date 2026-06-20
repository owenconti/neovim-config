#!/usr/bin/env bash
#
# install.sh — set up this Neovim config on a new macOS machine.
# Idempotent: safe to re-run. Installs CLI deps via Homebrew and clones this
# config directly to ~/.config/nvim. lazy.nvim + Mason + treesitter
# self-provision on first launch.
#
# Bootstrap on a fresh machine:
#   curl -fsSL https://raw.githubusercontent.com/owenconti/neovim-config/main/install.sh | bash
#
set -euo pipefail

REPO_URL="https://github.com/owenconti/neovim-config.git"
NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }

# --- this config targets macOS + Homebrew -----------------------------------
if [[ "$(uname -s)" != "Darwin" ]]; then
  warn "This installer targets macOS. On other systems, install the deps"
  warn "listed in README.md with your package manager, then clone this repo"
  warn "to $NVIM_CONFIG yourself."
fi

# --- Homebrew ----------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # make brew available for the rest of this script (Apple Silicon path)
  [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
else
  log "Homebrew already installed."
fi

# --- C compiler (treesitter builds parsers from source) ---------------------
if ! xcode-select -p >/dev/null 2>&1; then
  log "Installing Xcode Command Line Tools (C compiler for treesitter)…"
  xcode-select --install || warn "Finish the GUI prompt, then re-run this script."
else
  log "Xcode Command Line Tools present."
fi

# --- CLI dependencies --------------------------------------------------------
# Required by the editor + config (telescope, lazygit, lazy.nvim cloning, etc.)
CORE_PKGS=(neovim git ripgrep fd lazygit fzf)
# Mason-managed LSP servers and tooling lean on these.
TOOLING_PKGS=(node python3)
# Uncomment if you do PHP work on this machine (php-on-save, intelephense):
# TOOLING_PKGS+=(php composer)

log "Installing CLI dependencies via Homebrew…"
brew install "${CORE_PKGS[@]}" "${TOOLING_PKGS[@]}"

# --- Nerd Font (icons in lualine / nvim-tree / dashboard) -------------------
if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
  log "Installing JetBrains Mono Nerd Font…"
  brew install --cask font-jetbrains-mono-nerd-font || \
    warn "Font install failed — set any Nerd Font in your terminal manually."
else
  log "Nerd Font already installed."
fi

# --- Clone this config directly to ~/.config/nvim ---------------------------
if [[ -d "$NVIM_CONFIG/.git" ]] && \
   git -C "$NVIM_CONFIG" remote get-url origin 2>/dev/null | grep -q "neovim-config"; then
  log "Config already at $NVIM_CONFIG — pulling latest…"
  git -C "$NVIM_CONFIG" pull --ff-only || warn "Couldn't fast-forward; leaving as-is."
elif [[ -e "$NVIM_CONFIG" ]]; then
  backup="${NVIM_CONFIG}.backup-$(date +%Y%m%d%H%M%S)"
  warn "Existing $NVIM_CONFIG found — backing up to $backup"
  mv "$NVIM_CONFIG" "$backup"
  log "Cloning config to $NVIM_CONFIG…"
  git clone "$REPO_URL" "$NVIM_CONFIG"
else
  mkdir -p "$(dirname "$NVIM_CONFIG")"
  log "Cloning config to $NVIM_CONFIG…"
  git clone "$REPO_URL" "$NVIM_CONFIG"
fi

log "Done. Launch 'nvim' — lazy.nvim, Mason, and treesitter will self-provision on first run."
