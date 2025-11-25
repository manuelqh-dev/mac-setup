#!/usr/bin/env bash
set -euo pipefail

# Desactivar analytics de Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Si brew ya existe, actualizar y salir
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew ya instalado: $(brew --version | head -n1)"
  # Permitir fallos no críticos sin abortar
  brew update || true
  brew upgrade || true
  exit 0
fi

echo "Instalando Homebrew.."

# Descarga y ejecuta el instalador;
# NONINTERACTIVE intenta evitar prompts interactivos del instalador
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 'brew shellenv' imprime los exports necesarios; eval los aplica a la sesión actual
if [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)" || true
fi

# Mostrar configuración para verificar
brew config || true