{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.development.python;
in
{
  options.reiki.modules.development.python = {
    enable = mkEnableOption "Python configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
    ];
  };
}
