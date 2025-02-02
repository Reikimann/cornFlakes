{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.swww;
in
{
  options.reiki.modules.desktop.swww = {
    enable = mkEnableOption "Swww configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      swww-utils
    ];
  };
}
