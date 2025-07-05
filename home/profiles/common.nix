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
      file
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
    home.sessionVariables = {
      LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
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
        bat.enable = true;
        btop.enable = true;
        tmux.enable = true;
        yazi.enable = true;
      };
      development.editors.nvim.enable = true;
    };
  };
}
