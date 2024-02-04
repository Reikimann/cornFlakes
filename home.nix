{ config, lib, pkgs, ... }:

{
  home.username = "reikimann";
  home.homeDirectory = "/home/reikimann";
  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # hello
    neo-cowsay
    lolcat

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/reikimann/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      autocd = true;
      defaultKeymap = "viins";

      syntaxHighlighting = true;
      enableAutosuggestions = true;
      enableCompletion = true;

      history = {
        ignoreDups = true; # TODO: true by default. Do I even need it?
        save = 512;
      };

      dotDir = ".config/zsh";
    };

    # TODO: Don't want to include email, but its not working otherwise.
    # Maybe use ssh instead.
    git = {
      enable = false;
      userName = "Reikimann";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "store --file ~/.config/git/.git-credentials";
        safe.directory = "/opt/flutter";
      };
    };

    zoxide = {
      enable = false;
      enableZshIntegration = true;
    };

    # TODO: Find a way to include the configuration
    starship = {
      enable = false;
      enableZshIntegration = true;
    };

    # TODO:
    # btop
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
