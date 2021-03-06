[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ -n "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME="$HOME/.cache"
[[ -n "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"
[[ -n "$XDG_BIN_HOME" ]] || export XDG_BIN_HOME="$HOME/.local/bin"

[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
