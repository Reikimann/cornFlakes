{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
  ];
}
