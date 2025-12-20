#!/usr/bin/env bash
set -euo pipefail

export HOMEBREW_NO_ANALYTICS=1

if command -v brew >/dev/null 2>&1; then
  echo "Homebrew ya instalado: $(brew --version | head -n1)"
  brew update || true
  brew upgrade || true
  exit 0
fi

echo "Instalando Homebrew..."

# Instalador oficial
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Apple Silicon path
BREW_PREFIX="/opt/homebrew"

if [[ -x "$BREW_PREFIX/bin/brew" ]]; then
  # Aplicar a la sesión actual
  eval "$("$BREW_PREFIX/bin/brew" shellenv)"

  # Persistir para futuras sesiones (zsh es el default)
  if ! grep -q 'eval "\$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile 2>/dev/null; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  fi
else
  echo "ERROR: Homebrew no encontrado en $BREW_PREFIX"
  exit 1
fi

brew config
