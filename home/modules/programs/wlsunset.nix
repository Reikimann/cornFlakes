{ pkgs, config, lib, ... }:

{
  services.wlsunset = {
    enable = true;
    sunrise = "7:00";
    sunset = "17:00";
  };
}
