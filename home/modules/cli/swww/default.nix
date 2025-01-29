{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.swww;
in
{
  options.reiki.modules.cli.swww = {
    enable = mkEnableOption "Swww configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      # TODO: Am I actually using this (waybar)? Should I remove it in favor of xdg.configFile?
      # Or should I make it into an actual package?
      (writeShellApplication {
        name = "swww_changebg";
        runtimeInputs = [ swww fd ];
        text = ''
          #!/bin/sh

          WALLPAPER=$(fd --type=f . "$RICE_WALL_DIR" | shuf -n 1)

          swww img "$WALLPAPER" \
            --transition-bezier .43,1.19,1,.4 \
            --transition-type grow \
            --transition-duration 1 \
            --transition-fps 90 \
            --transition-step 255 \
            --transition-pos top-right
        '';
      })
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
