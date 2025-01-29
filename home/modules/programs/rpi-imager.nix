{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.rpi-imager;
in
{
  options.reiki.modules.programs.rpi-imager = {
    enable = mkEnableOption "Raspberry Pi Imager configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rpi-imager
    ];
  };
}
