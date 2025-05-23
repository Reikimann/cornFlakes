{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.wofi;
in
{
  options.reiki.modules.desktop.wofi = {
    enable = mkEnableOption "Wofi configuration";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = false;
      settings = {
        stylesheet = "style.css";
        show = "drun";
        matching = "fuzzy";
        no_actions = true;
        width = 550;
        height = 325;
        always_parse_args = true;
        show_all = true;
        print_command = true;
        layer = "overlay";
        insensitive = true;
        prompt = "Search...";
        allow_markup = true;
        allow_images = true;
        key_up = "Ctrl-k";
        key_down = "Ctrl-j";
        key_submit = "Ctrl-l";
      };
    };

    home.file.".config/wofi/style.css".source = ./style.css;
  };
}
