{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.profiles.common;
in
{
  options.reiki.profiles.common = {
    enable = mkEnableOption "Common profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zip
      unzip
      ripgrep
      fd
      duf
      gdu
    ];

    programs.home-manager.enable = true;

    i18n.glibcLocales = pkgs.glibcLocales.override {
      allLocales = false;
      locales = [ "en_DK.UTF-8/UTF-8" ];
    };

    reiki.modules = {
      shell = {
        bash.enable = true;
        zsh.enable = true;
        xdg = {
          enable = true;
          enableUserDirs = true;
        };
      };
      cli = {
        fzf.enable = true;
        eza = {
          enable = true;
          enableIntegrations = true;
        };
      };
      editors = {
        nvim.enable = true;
      };
    };
  };
}
