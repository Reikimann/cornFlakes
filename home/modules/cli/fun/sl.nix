{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.sl;
in
{
  options.reiki.modules.cli.sl = {
    enable = mkEnableOption "Sl configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sl
    ];
  };
}
