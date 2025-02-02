{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.playerctl;
in
{
  options.reiki.modules.desktop.playerctl = {
    enable = mkEnableOption "Playerctl configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ playerctl ];
    services.playerctld = {
      enable = true;
    };
  };
}
