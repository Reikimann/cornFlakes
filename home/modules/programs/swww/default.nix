{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
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
}
