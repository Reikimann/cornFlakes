{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gdu
    duf
    xdg-ninja
  ];
}
