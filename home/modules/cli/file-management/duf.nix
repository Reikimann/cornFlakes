{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.duf;
in
{
  options.reiki.modules.cli.duf = {
    enable = mkEnableOption "Disk Usage/Free configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      duf
    ];
  };
}
