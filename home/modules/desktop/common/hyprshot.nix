{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.hyprshot;
in
{
  options.reiki.modules.desktop.hyprshot = {
    enable = mkEnableOption "Hyprshot configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprshot
    ];

    home.sessionVariables = {
      HYPRSHOT_DIR = "${config.xdg.userDirs.pictures}/screenshots";
    };
  };
}
