{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.just;
in
{
  options.reiki.modules.cli.just = {
    enable = mkEnableOption "Just configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      just
    ];
  };
}
