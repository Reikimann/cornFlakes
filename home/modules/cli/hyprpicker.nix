{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.hyprpicker;
in
{
  options.reiki.modules.cli.hyprpicker = {
    enable = mkEnableOption "Hyprpicker configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpicker
    ];
  };
}
