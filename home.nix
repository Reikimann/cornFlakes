{ pkgs, config, outputs, ... }:

{
  imports = [
    ./home/modules
  ];

  home = {
    username = "reikimann";
    homeDirectory = "/home/reikimann";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
    preferXdgDirectories = true;

    sessionVariables = {
      LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
      RICE_WALL_DIR = "${config.xdg.userDirs.pictures}/wallpapers/rices/tokyonight";
    };

    file."pix/wallpapers".source = ./wallpapers;
  };

  programs = {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  nixpkgs = {
    overlays = outputs.overlays;
    config = import ./nix/config.nix;
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  i18n.glibcLocales = pkgs.glibcLocales.override {
      allLocales = false;
      locales = [ "en_DK.UTF-8/UTF-8" ];
  };
}
