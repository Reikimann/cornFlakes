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
    # File management
    gdu
    duf
    xdg-ninja

    # Shell
    tmux
    yt-dlp
    bat
    eza

    # Sysops
    rpi-imager
    just

    # Networking
    nmap

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

  i18n.glibcLocales = pkgs.glibcLocales.override {
      allLocales = false;
      locales = [ "en_DK.UTF-8/UTF-8" ];
  };

  home.sessionVariables = {
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };

  imports = [
    ./home/modules
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

    # TODO:
    # btop
  };
}
