#!/bin/bash

# -----------------------------------------------------------
# Script de instalación de aplicaciones y utilidades macOS
# Para Mac Intel con Homebrew
# -----------------------------------------------------------

# Comprobamos que Homebrew esté instalado
if ! command -v brew &> /dev/null; then
    echo "Homebrew no está instalado. Ejecuta primero install_homebrew.sh"
    exit 1
fi

# Actualizamos Homebrew
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

#############################################
# curl (usar versión de Homebrew por defecto)
#############################################

# Instalar curl con Homebrew
brew install curl

# Asegurar que el curl de Homebrew está primero en el PATH
BREW_CURL_PATH="/usr/local/opt/curl/bin"
BREW_CURL_LIB="/usr/local/opt/curl/lib"
BREW_CURL_INCLUDE="/usr/local/opt/curl/include"

# Añadir al PATH solo si no está ya presente
if ! grep -q "$BREW_CURL_PATH" ~/.zshrc; then
    echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.zshrc
    echo "[INFO] Añadido curl de Homebrew al PATH en ~/.zshrc"
else
    echo "[INFO] curl de Homebrew ya está en el PATH"
fi

# Añadir LDFLAGS si no está ya
if ! grep -q "LDFLAGS=.*$BREW_CURL_LIB" ~/.zshrc; then
    echo 'export LDFLAGS="-L/usr/local/opt/curl/lib"' >> ~/.zshrc
    echo "[INFO] Añadido LDFLAGS para curl en ~/.zshrc"
else
    echo "[INFO] LDFLAGS ya configurado para curl"
fi

# Añadir CPPFLAGS si no está ya
if ! grep -q "CPPFLAGS=.*$BREW_CURL_INCLUDE" ~/.zshrc; then
    echo 'export CPPFLAGS="-I/usr/local/opt/curl/include"' >> ~/.zshrc
    echo "[INFO] Añadido CPPFLAGS para curl en ~/.zshrc"
else
    echo "[INFO] CPPFLAGS ya configurado para curl"
fi

# -----------------------------------------------------------
# IDEs / Editores / Aplicaciones de productividad
# -----------------------------------------------------------
echo "Instalando aplicaciones de productividad..."
brew install --cask visual-studio-code
brew install --cask obsidian

# -----------------------------------------------------------
# Terminal
# -----------------------------------------------------------
echo "Instalando terminal Ghostty..."
brew install --cask ghostty

# -----------------------------------------------------------
# Fuentes
# -----------------------------------------------------------
echo "Instalando fuentes JetBrains Mono..."
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font

# -----------------------------------------------------------
# Zsh + Zinit (gestor de plugins Zsh)
# -----------------------------------------------------------
echo "Instalando Zsh..."
brew install zsh

# establecer zsh de Homebrew como shell por defecto
chsh -s /opt/homebrew/bin/zsh

if [[ ! -d "$HOME/.local/share/zinit/zinit.git" ]]; then
    echo "Instalando Zinit..."
    mkdir -p "$HOME/.local/share/zinit"
    chmod g-rwX "$HOME/.local/share/zinit"
    git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" \
        && echo "Zinit instalado correctamente." \
        || echo "Error al clonar Zinit."
else
    echo "Zinit ya está instalado, saltando..."
fi

# -----------------------------------------------------------
# Limpieza
# -----------------------------------------------------------
echo "Limpiando Homebrew..."
brew cleanup

echo "¡Instalación completada!"