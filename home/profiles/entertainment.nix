{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.profiles.entertainment;
in 
{
  options.reiki.profiles.entertainment = {
    enable = mkEnableOption "Entertainment profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sl
      lolcat
      fortune
      unimatrix
      neo-cowsay
      asciiquarium-transparent
    ];

    reiki.modules = {
      cli = {
        neofetch.enable = true;
      };
    };
  };
}
