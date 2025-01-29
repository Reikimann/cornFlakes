{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.lolcat;
in
{
  options.reiki.modules.cli.lolcat = {
    enable = mkEnableOption "Lolcat configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lolcat
    ];
  };
}
