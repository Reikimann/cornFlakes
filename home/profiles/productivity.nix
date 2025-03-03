{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.profiles.productivity;
in
{
  options.reiki.profiles.productivity = {
    enable = mkEnableOption "Productivity profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
      gimp
    ];

    reiki.modules = {
      productivity = {
        zathura.enable = true;
        figma.enable = true;
      };
    };
  };
}
