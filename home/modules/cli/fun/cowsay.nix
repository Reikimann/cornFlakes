{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.cowsay;
in
{
  options.reiki.modules.cli.cowsay = {
    enable = mkEnableOption "Cowsay configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neo-cowsay
    ];
  };
}
