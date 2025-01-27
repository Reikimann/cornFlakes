{ pkgs, config, outputs, ... }:

{
  imports = [
    ../../home/modules
  ];

  # TODO: Move to profiles
  reiki.modules = {
    programs = {
      swaylock.enable = true;
      swww.enable = true;
      waybar = {
        enable = true;
        outputScreen = "DP-1";
      };
      wlogout.enable = true;
      wofi.enable = false; # Just for remembering adding to profiles
      kitty.enable = true;
      rofi.enable = true;
      firefox.enable = true;
      zathura.enable = true;
      anytype = {
        enable = true;
        disableWayland = true;
      };
      discord.enable = true;
      signal-desktop.enable = true;
      spotify.enable = true;
    };
    services = {
      wlsunset.enable = true;
      dunst.enable = true;
    };
    shell = {
      bash.enable = true;
      zsh.enable = true;
      xdg = {
        enable = true;
        enableUserDirs = true;
      };
    };
    editors = {
      nvim.enable = true;
    };
  };

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

    file."pix/wallpapers".source = ../../wallpapers;
  };

  programs = {
    home-manager.enable = true;
  };

  targets.genericLinux.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  nixpkgs = {
    overlays = outputs.overlays;
    config = import ../../nix/config.nix;
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
