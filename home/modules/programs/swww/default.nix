{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.swww;
in
{
  # TODO: Maybe make a folder for desktop stuff (not /home/desktops) like bars and lockscreens
  options.reiki.modules.programs.swww = {
    enable = mkEnableOption "Swww configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      # FIX: Am I actually using this? Should I remove it in favor of xdg.configFile?
      (writeScriptBin "swww_changebg" ''
        #!/bin/sh

        WALLPAPER=$(fd --type=f . "$RICE_WALL_DIR" | shuf -n 1)

        swww img "$WALLPAPER" \
          --transition-bezier .43,1.19,1,.4 \
          --transition-type grow \
          --transition-duration 1 \
          --transition-fps 90 \
          --transition-step 255 \
          --transition-pos top-right
      '')
    ];

    xdg.configFile."swww/swww_changebg.sh" = {
      source = ./swww_changebg.sh;
      executable = true;
    };

    xdg.configFile."swww/swww_randomize.sh" = {
      source = ./swww_randomize.sh;
      executable = true;
    };
  };
}
