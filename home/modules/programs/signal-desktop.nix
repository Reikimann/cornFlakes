{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.signal-desktop;
in
{
  options.reiki.modules.programs.signal-desktop = {
    enable = mkEnableOption "Signal Desktop configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
