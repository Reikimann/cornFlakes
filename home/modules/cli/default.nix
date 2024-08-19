{ pkgs, ... }:

{
  imports = [
    ./neofetch
    ./yazi
    ./btop.nix
    ./file_management.nix
    ./fun.nix
    ./fzf.nix
    #./git.nix  TODO: Fix git
  ];

  # Not sorted
  home.packages = with pkgs; [
    # Shell
    tmux
    yt-dlp
    bat
    eza
    fd

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
