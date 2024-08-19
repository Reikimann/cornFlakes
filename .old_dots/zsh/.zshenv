export LC_ALL=en_DK.UTF-8

#############Home Fixes#################

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export MOZ_DBUS_REMOTE=1

export LESSOPEN="| /usr/bin/bat -f %s 2>/dev/null"
