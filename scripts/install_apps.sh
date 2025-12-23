#!/bin/bash

# -----------------------------------------------------------
# Script de instalación de aplicaciones y utilidades macOS
# Para Mac Apple Silicon con Homebrew
# -----------------------------------------------------------

set -e

# -----------------------------------------------------------
# Comprobación Homebrew
# -----------------------------------------------------------
if ! command -v brew &> /dev/null; then
    echo "Homebrew no está instalado. Ejecuta primero install_homebrew.sh"
    exit 1
fi

# -----------------------------------------------------------
# Actualizar Homebrew
# -----------------------------------------------------------
echo "Actualizando Homebrew..."
brew update

# -----------------------------------------------------------
# CLI Utilities
# -----------------------------------------------------------
echo "Instalando utilidades de línea de comandos..."
brew install git
brew install wget
brew install openssl
brew install python
brew install curl

# -----------------------------------------------------------
# curl (usar versión de Homebrew)
# -----------------------------------------------------------
BREW_PREFIX="$(brew --prefix)"
CURL_PREFIX="$(brew --prefix curl)"

BREW_CURL_PATH="$CURL_PREFIX/bin"
BREW_CURL_LIB="$CURL_PREFIX/lib"
BREW_CURL_INCLUDE="$CURL_PREFIX/include"

ZSHRC="$HOME/.zshrc"

# PATH
if ! grep -q "$BREW_CURL_PATH" "$ZSHRC"; then
    echo "export PATH=\"$BREW_CURL_PATH:\$PATH\"" >> "$ZSHRC"
    echo "[INFO] Añadido curl de Homebrew al PATH"
fi

# LDFLAGS
if ! grep -q "$BREW_CURL_LIB" "$ZSHRC"; then
    echo "export LDFLAGS=\"-L$BREW_CURL_LIB\"" >> "$ZSHRC"
    echo "[INFO] Añadido LDFLAGS para curl"
fi

# CPPFLAGS
if ! grep -q "$BREW_CURL_INCLUDE" "$ZSHRC"; then
    echo "export CPPFLAGS=\"-I$BREW_CURL_INCLUDE\"" >> "$ZSHRC"
    echo "[INFO] Añadido CPPFLAGS para curl"
fi

# -----------------------------------------------------------
# Rosetta 2
# -----------------------------------------------------------
if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
    echo "Instalando Rosetta 2..."
    softwareupdate --install-rosetta --agree-to-license
else
    echo "Rosetta 2 ya está instalada, saltando..."
fi

# -----------------------------------------------------------
# Apps
# -----------------------------------------------------------
echo "Instalando aplicaciones de productividad..."
brew install --cask visual-studio-code
brew install --cask obsidian
brew install --cask launchos
brew install --cask steam
brew install --cask stats
brew install --cask appcleaner
brew install --cask logi-options+

# -----------------------------------------------------------
# Terminal
# -----------------------------------------------------------
echo "Instalando terminal Ghostty..."
brew install --cask ghostty

# -----------------------------------------------------------
# Navegadores
# -----------------------------------------------------------
echo "Instalando navegador Brave..."
brew install --cask brave-browser

# -----------------------------------------------------------
# Fuentes
# -----------------------------------------------------------
echo "Instalando fuentes JetBrains Mono..."
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font

# -----------------------------------------------------------
# Zsh + Zinit
# -----------------------------------------------------------
echo "Instalando Zsh..."
brew install zsh

# Establecer zsh de Homebrew como shell por defecto
if ! grep -q "$BREW_PREFIX/bin/zsh" /etc/shells; then
    echo "$BREW_PREFIX/bin/zsh" | sudo tee -a /etc/shells > /dev/null
fi

chsh -s "$BREW_PREFIX/bin/zsh"

# Zinit
ZINIT_DIR="$HOME/.local/share/zinit/zinit.git"

if [[ ! -d "$ZINIT_DIR" ]]; then
    echo "Instalando Zinit..."
    mkdir -p "$(dirname "$ZINIT_DIR")"
    chmod g-rwX "$HOME/.local/share/zinit"
    git clone https://github.com/zdharma-continuum/zinit "$ZINIT_DIR"
else
    echo "Zinit ya está instalado, saltando..."
fi

# -----------------------------------------------------------
# Limpieza
# -----------------------------------------------------------
echo "Limpiando Homebrew..."
brew cleanup

echo "Instalación completada para Apple Silicon."
