{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.fd;
in
{
  options.reiki.modules.cli.fd = {
    enable = mkEnableOption "Fd configuration";
  };

  config = mkIf cfg.enable {
    programs.fd.enable = true;
  };
}
