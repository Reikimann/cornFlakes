{ pkgs, ... }:

{
  imports = [
    ./hyprland
  ];

  # TODO: Move to some other module place
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 20;
  };
}
