{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.unimatrix;
in
{
  options.reiki.modules.cli.unimatrix = {
    enable = mkEnableOption "Unimatrix configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unimatrix
    ];
  };
}
