{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.asciiquarium;
in
{
  options.reiki.modules.cli.asciiquarium = {
    enable = mkEnableOption "Asciiquarium configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      asciiquarium-transparent
    ];
  };
}
