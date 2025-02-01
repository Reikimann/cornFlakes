{ pkgs, lib, config, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.neofetch;
in
{
  options.reiki.modules.cli.neofetch = {
    enable = mkEnableOption "Neofetch configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neofetch
    ];

    home.file.".config/neofetch/config.conf".source = ./config.conf;
  };
}
