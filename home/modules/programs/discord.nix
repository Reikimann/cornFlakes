{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.discord;
in
{
  options.reiki.modules.programs.discord = {
    enable = mkEnableOption "Discord configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
