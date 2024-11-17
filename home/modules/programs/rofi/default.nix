{ pkgs, config, lib, ... }:
{
  # TODO: Doesn't work because of NixOS Locales
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "themes/cherry";
    font = "Liga SFMono Nerd Font 13";
    extraConfig = {
      modi = "window,drun,ssh,combi,run";
      show-icons = true;
      matching = "regex";
      combi-modi = "drun,run";

      kb-row-up = "Control+k";
      kb-row-down = "Control+j";
      kb-remove-to-eol = "";
      kb-accept-entry = "Control+m,Return,KP_Enter";
    };
  };
  home.file.".config/rofi/themes".source = ./themes;
}
