# Mac Setup

Este repositorio contiene scripts y configuraciones para preparar un mac desde cero.

---

## Estructura del repositorio

```
mac-setup/
├── README.md
├── scripts/
│ ├── install_homebrew.sh # Instala Homebrew
│ ├── install_apps.sh # Instala aplicaciones y herramientas
│ ├── setup_git.sh # Configuración de Git
│ └── setup_ssh.sh # Configuración de SSH
├── dotfiles/
│ ├── .zshrc
│ └── .p10k.zsh
```

---

## Uso

1. Clonar el repositorio:

```
git clone git@github.com:TU-USUARIO/mac-setup.git
cd mac-setup
```

2. Dar permisos de ejecución a los scripts:

```
chmod +x scripts/*.sh
```
3. Ejecutar los scripts en orden:

```
./scripts/install_homebrew.sh
./scripts/install_apps.sh
```

4. Opcionalmente, ejecutar scripts de configuración:

```
./scripts/setup_git.sh
./scripts/setup_ssh.sh
```

5. Copiar dotfiles

```
cp dotfiles/.zshrc ~/
cp dotfiles/.p10k.zsh ~/
```
