{ pkgs, config, outputs, ... }:

{
  imports = [
    ../../home/modules
    ../../home/profiles
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
  reiki = {
    modules = {
      desktops = {
        hyprland.enable = true;
        cursor.enable = true;
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
      cli = {
        brightnessctl.enable = true;
        btop.enable = true;
        playerctl.enable = true;
        swww.enable = true;
        tmux.enable = true;
# File management
        bat.enable = true;
        xdg-ninja.enable = true;
        yazi.enable = true;
        yt-dlp.enable = true;
      };
    };
    profiles = {
      common.enable = true;
      development.enable = true;
      entertainment.enable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    RICE_WALL_DIR = "${config.xdg.userDirs.pictures}/wallpapers/rices/tokyonight";
  };

  home.file."pix/wallpapers".source = ../../wallpapers;

  # TODO: Add below to mkHome (see EdenEast/nyx)
  home = {
    username = "reikimann";
    homeDirectory = "/home/reikimann";
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
}
