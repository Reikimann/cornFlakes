{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.nmap;
in
{
  options.reiki.modules.cli.nmap = {
    enable = mkEnableOption "NMap configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nmap
    ];
  };
}
