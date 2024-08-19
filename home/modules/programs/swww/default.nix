{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  xdg.configFile."swww/swww_changebg.sh" = {
    source = ./swww_changebg.sh;
    executable = true;
  };

  xdg.configFile."swww/swww_randomize.sh" = {
    source = ./swww_randomize.sh;
    executable = true;
  };
}
