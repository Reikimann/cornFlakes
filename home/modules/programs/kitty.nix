{ pkgs, config, lib, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Liga SFMono Nerd Font";
      size = 14.0;
    };
    theme = "Tokyo Night";
    settings = {
      enable_audio_bell = false;
      tab_bar_style = "powerline";
      confirm_os_window_close = 0;
    };
  };
}
