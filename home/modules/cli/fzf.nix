{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.fzf;
in
{
  options.reiki.modules.cli.fzf = {
    enable = mkEnableOption "Fzf configuration";
  };

  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--info=inline"
        "--cycle"
      ];
    };
  };
}
