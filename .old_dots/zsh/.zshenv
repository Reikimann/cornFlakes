typeset -U path PATH
path=(~/.local/bin $path)
export PATH

export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

export VISUAL="nvim"
export EDITOR="$VISUAL"
export TERMINAL="kitty"
export BROWSER="waterfox-g4"
export READER="zathura"
export LC_ALL=en_DK.UTF-8
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline --cycle'

#############Home Fixes#################

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export ZDOTDIR="$HOME/.config/zsh"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export MOZ_DBUS_REMOTE=1

export PATH="$CARGO_HOME/bin:$PATH"

#############Less Fixes#################

export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/bat -f %s 2>/dev/null"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
