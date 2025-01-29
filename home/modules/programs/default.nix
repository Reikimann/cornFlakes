{ pkgs, ... }:

{
  imports = [
    ./anytype.nix
    ./kitty.nix
    ./spotify.nix
    ./discord.nix
    ./signal-desktop.nix
    ./zathura.nix
    ./swaylock
    ./rofi
    ./firefox
    ./swww
    ./waybar
    ./wlogout
    ./wofi
  ];

  # TODO: Modules: Not sorted yet
  home.packages = with pkgs; [
    keepassxc
    brightnessctl
    playerctl
    hyprpicker
    lunatask
    ungoogled-chromium
    rpi-imager
    # pkgs.kicad
  ];
}
