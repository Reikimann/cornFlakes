{ pkgs, config, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      source = [
        "~/.config/hypr/binds.conf"
        "~/.config/hypr/windowrules.conf"
        "~/.config/hypr/input.conf"
        "~/.config/hypr/tempConfHyprland.conf"
      ];
    };
  };


  home.file.".config/hypr/tempConfHyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/binds.conf".source = ./binds.conf;
  home.file.".config/hypr/input.conf".source = ./input.conf;
  home.file.".config/hypr/windowrules.conf".source = ./windowrules.conf;
}
