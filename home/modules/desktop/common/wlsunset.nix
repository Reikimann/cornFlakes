{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.wlsunset;
in
{
  options.reiki.modules.desktop.wlsunset = {
    enable = mkEnableOption "Day/night gamma adjustment service";
    sunrise = mkOption {
      description = "Override sunrise time";
      default = "7:00";
      type = types.str;
    };
    sunset = mkOption {
      description = "Override sunset time";
      default = "22:00";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    services.wlsunset = {
      enable = true;
      sunrise = cfg.sunrise;
      sunset = cfg.sunset;
    };
  };
}
