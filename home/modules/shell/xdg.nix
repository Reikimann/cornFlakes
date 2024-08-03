{ config, ... }:
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/dox";
      download = "${config.home.homeDirectory}/dl";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pix";
      videos = "${config.home.homeDirectory}/vids";
      desktop = null;
      templates = null;
      publicShare = null;
    };
  };
}
