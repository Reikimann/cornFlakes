{ config, lib, pkgs, ... }:

{
  home.username = "reikimann";
  home.homeDirectory = "/home/reikimann";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";

  targets.genericLinux.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.packages = with pkgs; [
    # Fun
    neo-cowsay
    lolcat
    fortune
    asciiquarium-transparent
    sl
    neofetch

    # File management
    gdu
    duf
    xdg-ninja

    # Terminal
    tmux
    yt-dlp
    bat
    eza

    # Sysops
    rpi-imager
    just

    # Networking
    nmap

    # Other
    rofi-wayland

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  i18n.glibcLocales = pkgs.glibcLocales.override {
      allLocales = false;
      locales = [ "en_DK.UTF-8/UTF-8" ];
  };

  imports = [
    ./modules/shells
  ];

  programs = {
    home-manager.enable = true;

    # TODO: Don't want to include email, but its not working otherwise.
    # Setup ssh instead.
    #git = {
    #  enable = true;
    #  userName = "Reikimann";
    #  extraConfig = {
    #    init.defaultBranch = "main";
    #    credential.helper = "store --file ~/.config/git/.git-credentials";
    #    safe.directory = "/opt/flutter";
    #  };
    #};

    # Config not done
    # rofi = {
    #   enable = true;
    #   package = pkgs.rofi-wayland;
    # };

    # TODO:
    # btop

    # https://github.com/KFearsoff/NixOS-config/blob/main/nixosModules/neovim/default.nix
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        gcc # needed for nvim-treesitter
        cmake # for telescope
        ripgrep # for telescope
      ];
    };

  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/dox";
      download = "${config.home.homeDirectory}/dl";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pix";
      videos = "${config.home.homeDirectory}/vids";
      desktop = null;
      templates = null;
      publicShare = null;
    };
  };
}
