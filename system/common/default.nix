{ outputs, pkgs, ... }:

{
  imports = [
    ./gaming.nix
  ];

  nixpkgs = {
    overlays = outputs.overlays;
    config = import ../../nix/config.nix;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # TODO: Make this into a module
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  environment.systemPackages = [ pkgs.killall ];

  # USB-mounting
  services = {
    udisks2.enable = true;
    devmon.enable = true;
  };


  # TODO: How to correctly set these variables?
  programs.less = {
    enable = true;
    envVariables = {
      # TODO: Does it recognise this? lib.exe printf maybe
      #LESSOPEN="| '${lib.getBin pkgs.bat}/bin/bat -f %s 2>/dev/null";
      LESS = "iR";
      #LESS=iFMRSX
      #LESS_TERMCAP_mb = "$(printf '%b' '[1;31m')";
      #LESS_TERMCAP_md = "$(printf '%b' '[1;36m')";
      #LESS_TERMCAP_me = "$(printf '%b' '[0m')";
      #LESS_TERMCAP_so = "$(printf '%b' '[01;44;33m')";
      #LESS_TERMCAP_se = "$(printf '%b' '[0m')";
      #LESS_TERMCAP_us = "$(printf '%b' '[1;32m')";
      #LESS_TERMCAP_ue = "$(printf '%b' '[0m')";

      #LESS_TERMCAP_mb = "$'\E[01;31m'";
      #LESS_TERMCAP_md = "$'\E[01;38;5;208m'";
      #LESS_TERMCAP_me = "$'\E[0m'";
      #LESS_TERMCAP_so = "$'\E[01;44;33m'";
      #LESS_TERMCAP_se = "$'\E[0m'";
      #LESS_TERMCAP_us = "$'\E[04;38;5;111m'";
      #LESS_TERMCAP_ue = "$'\E[0m'";
    };
  };

  #environment.variables = {
  #  # i = case-insensitive searches, unless uppercase characters in search string
  #  # F = exit immediately if output fits on one screen
  #  # M = verbose prompt
  #  # R = ANSI color support
  #  # S = chop long lines (rather than wrap them onto next line)
  #  # X = suppress alternate screen
  #  LESS="-R";
  #  #LESS=iFMRSX
  #  LESS_TERMCAP_mb="$(printf '%b' '[1;31m')";
  #  LESS_TERMCAP_md="$(printf '%b' '[1;36m')";
  #  LESS_TERMCAP_me="$(printf '%b' '[0m')";
  #  LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')";
  #  LESS_TERMCAP_se="$(printf '%b' '[0m')";
  #  LESS_TERMCAP_us="$(printf '%b' '[1;32m')";
  #  LESS_TERMCAP_ue="$(printf '%b' '[0m')";


  #  # Color man pages.
  #  #LESS_TERMCAP_mb="$'\E[01;31m'";
  #  #LESS_TERMCAP_md="$'\E[01;38;5;208m'";
  #  #LESS_TERMCAP_me="$'\E[0m'";
  #  #LESS_TERMCAP_se="$'\E[0m'";
  #  #LESS_TERMCAP_ue="$'\E[0m'";
  #  #LESS_TERMCAP_us="$'\E[04;38;5;111m'";
  #};
}
