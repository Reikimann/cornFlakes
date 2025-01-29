{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.gdu;
in
{
  options.reiki.modules.cli.gdu = {
    enable = mkEnableOption "Graphical disk usage tool (gdu) configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gdu
    ];
  };
}
