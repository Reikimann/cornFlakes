{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.shell.xdg;
in
{
  options.reiki.modules.shell.xdg = {
    enable = mkEnableOption "XDG base directories configuration";
    enableUserDirs = mkOption {
      description = "Enables management of XDG user directories";
      default = false;
      type = types.bool;
    };
  };

  # TODO: Setup xdg.desktopEntries from /.old_dots
  config = mkIf cfg.enable {
    xdg = {
      enable = true;
      userDirs = {
        enable = cfg.enableUserDirs;
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
  };
}
