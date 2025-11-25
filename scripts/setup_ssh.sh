#!/bin/bash
# ============================================================
# Crear y añadir clave SSH para GitHub
# ============================================================

echo "Configurando SSH para GitHub..."

# Generar clave SSH si no existe
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    ssh-keygen -t ed25519 -C "tu-email@dominio.com" -f "$SSH_KEY" -N ""
    echo "Clave SSH generada en $SSH_KEY"
else
    echo "La clave SSH ya existe en $SSH_KEY, saltando creación..."
fi

# Iniciar el agente SSH y añadir clave al Keychain
eval "$(ssh-agent -s)"
ssh-add -K "$SSH_KEY"

# Mostrar clave pública para añadir a GitHub
echo ""
echo "Copia la siguiente clave y añádela en GitHub -> Settings -> SSH and GPG keys -> New SSH key:"
echo ""
cat "$SSH_KEY.pub"
echo ""
echo "SSH configurado. Prueba la conexión con:"
echo "ssh -T git@github.com"