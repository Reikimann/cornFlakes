{ pkgs, config, ... }:

{
  imports = [
    ./home/modules
  ];

  home = {
    username = "reikimann";
    homeDirectory = "/home/reikimann";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";

    sessionVariables = {
      LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };

    file."pix/wallpapers".source = ./wallpapers;
  };

  programs = {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  i18n.glibcLocales = pkgs.glibcLocales.override {
      allLocales = false;
      locales = [ "en_DK.UTF-8/UTF-8" ];
  };
}
