{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.development.arduino;
in
{
  options.reiki.modules.development.arduino = {
    enable = mkEnableOption "Arduino configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      arduino-cli
      arduino-ide
    ];
  };
}
