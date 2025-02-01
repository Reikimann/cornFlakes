{ substituteAll, lib
, coreutils, getopt
, fd, swww
}:
substituteAll {
  name = "swww-utils";

  src = ./swww-utils.sh;

  dir = "bin";
  isExecutable = true;

  inherit fd swww coreutils getopt;

  meta = with lib; {
    description = "Swww Wallpaper Helper Utility";
    platforms = platforms.linux;
  };
}
