# ======================
# 🛠 PATH (priorizar Homebrew)
# ======================
export PATH="/usr/local/opt/curl/bin:/usr/local/opt/openssl@3/bin:/usr/local/opt/python@3.12/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/sbin:/bin"

# Variables para compilar y enlazar correctamente librerías de Homebrew
export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"

# ======================
# 🎨 Colores y Prompt
# ======================
autoload -U colors && colors
setopt PROMPT_SUBST
PROMPT='%F{215}%n%f %F{250}[%~]%f %F{111}➜%f '
RPROMPT='%F{#F5C2E7}[%?]%f'

# ======================
# 📂 Alias
# ======================
alias ls='ls --color=auto'

# ======================
# 📦 Zinit
# ======================
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}Installing %F{220}Zinit%f%b"
    command mkdir -p "$HOME/.local/share/zinit"
    command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" \
        && print -P "%F{33}Installation successful.%f%b" \
        || print -P "%F{160}Clone failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# ======================
# 🎯 Plugins
# ======================
## Tema Powerlevel10k
zinit light romkatv/powerlevel10k

## Plugins útiles
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# Cambiar la tecla TAB para aceptar la sugerencia
bindkey '^I' autosuggest-accept

# ======================
# 💡 Powerlevel10k Config
# ======================
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh