{ replaceVarsWith, lib
, coreutils, getopt
, fd, swww, bash
}:
replaceVarsWith {
  name = "swww-utils";

  src = ./swww-utils.sh;

  dir = "bin";
  isExecutable = true;

  replacements = {
    inherit fd swww coreutils getopt bash;
  };

  meta = with lib; {
    description = "Swww Wallpaper Helper Utility";
    platforms = platforms.linux;
  };
}
