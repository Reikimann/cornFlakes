{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.brightnessctl;
in
{
  options.reiki.modules.cli.brightnessctl = {
    enable = mkEnableOption "Brightnessctl configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
    ];
  };
}
