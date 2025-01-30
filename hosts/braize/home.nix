{ pkgs, config, outputs, ... }:

{
  imports = [
    ../../home/modules
  ];

  # Just for remembering adding to profiles/laptop
  isLaptop = false;

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 240;
      position = "auto"; # Auto is for hyprland. Can also use e.g. 0x0.
      primary = true;
      enabled = true;
    }
    {
      # https://wiki.hyprland.org/FAQ/#workspaces-or-clients-are-disappearing-or-monitor-related-dispatchers-cause-crashes
      name = "Unknown-1";
      enabled = false;
    }
  ];

  # TODO: Move to profiles
  reiki.modules = {
    desktops = {
      hyprland.enable = true;
    };
    programs = {
      anytype = {
        enable = true;
        disableWayland = true;
      };
      discord.enable = true;
      firefox.enable = true;
      keepassxc.enable = true;
      kitty.enable = true;
      lunatask.enable = true;
      rpi-imager.enable = true;
      signal-desktop.enable = true;
      spotify.enable = true;
      ungoogled-chromium.enable = true;
      zathura.enable = true;
      # Desktop (stuff)
      rofi.enable = true;
      swaylock.enable = true;
      waybar.enable = true;
      wlogout.enable = true;
      wofi.enable = false; # Just for remembering adding to profiles
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
    cli = {
      brightnessctl.enable = true;
      btop.enable = true;
      fzf.enable = true;
      hyprpicker.enable = true;
      just.enable = true;
      nmap.enable = true;
      playerctl.enable = true;
      swww.enable = true;
      tmux.enable = true;
      # File management
      bat.enable = true;
      duf.enable = true;
      eza = {
        enable = true;
        enableIntegrations = true;
      };
      fd.enable = true;
      gdu.enable = true;
      xdg-ninja.enable = true;
      yazi.enable = true;
      yt-dlp.enable = true;
      # Fun
      asciiquarium.enable = true;
      cowsay.enable = true;
      fortune.enable = true;
      lolcat.enable = true;
      sl.enable = true;
      unimatrix.enable = true;
    };
    editors = {
      nvim.enable = true;
    };
    development = {
      go.enable = true;
      nodejs.enable = true;
      python.enable = true;
      rust.enable = true;
      latex.enable = true;
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

  # TODO: Move to some other module place
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 20;
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
