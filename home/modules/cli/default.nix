{ pkgs, ... }:

{
  imports = [
    ./neofetch
    ./yazi
    ./btop.nix
    ./file_management.nix
    #./git.nix  TODO: Fix git
    ./fun.nix
  ];

  # Not sorted
  home.packages = with pkgs; [
    # Shell
    tmux
    yt-dlp
    bat
    eza

    # Development tools
    rpi-imager
    nmap
    just

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
