{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.fortune;
in
{
  options.reiki.modules.cli.fortune = {
    enable = mkEnableOption "Fortune configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fortune
    ];
  };
}
