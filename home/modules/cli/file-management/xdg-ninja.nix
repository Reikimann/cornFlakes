{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.xdg-ninja;
in
{
  options.reiki.modules.cli.xdg-ninja = {
    enable = mkEnableOption "XDG-ninja configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-ninja
    ];
  };
}
