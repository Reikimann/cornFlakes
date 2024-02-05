{ pkgs, lib, ... }:
{
  programs.less = {
    enable = true;
    envVariables = {
      LESS= "-R";
      # TODO: Does it recognise this? lib.exe printf maybe
      LESS_TERMCAP_mb="$(printf '%b' '[1;31m')";
      LESS_TERMCAP_md="$(printf '%b' '[1;36m')";
      LESS_TERMCAP_me="$(printf '%b' '[0m')";
      LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')";
      LESS_TERMCAP_se="$(printf '%b' '[0m')";
      LESS_TERMCAP_us="$(printf '%b' '[1;32m')";
      LESS_TERMCAP_ue="$(printf '%b' '[0m')";
      LESSOPEN="| /usr/bin/bat -f %s 2>/dev/null";
    };
  };
}


