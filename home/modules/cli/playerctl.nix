{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.playerctl;
in
{
  options.reiki.modules.cli.playerctl = {
    enable = mkEnableOption "Playerctl configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      playerctl
    ];
  };
}
