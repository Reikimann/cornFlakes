{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.swww;
in
{
  options.reiki.modules.cli.swww = {
    enable = mkEnableOption "Swww configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
      swww-utils
    ];
  };
}
