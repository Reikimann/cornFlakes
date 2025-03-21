{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.digital-wellbeing.bedtime-control;
  service-name = "bedtime-control";
in
{
  options.reiki.modules.digital-wellbeing.${service-name} = {
    enable = mkEnableOption "Bedtime control";
    description = "Disables the internet and reminds the user to go to bed";
  };

  config = mkIf cfg.enable {
    systemd.user = {
      services.${service-name} = {
        Unit = {
          Description = "Disables the internet and reminds the user to go to bed";
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.writeShellScript "${service-name}" ''
            ${pkgs.libnotify}/bin/notify-send "Turn off your PC now!" "The internet disconnects in 10 minutes :P" -u critical
            ${pkgs.coreutils}/bin/sleep 600
            ${pkgs.networkmanager}/bin/nmcli networking off
          ''}";
        };
      };

      timers.${service-name} = {
        Unit = {
          Description = "Disables the internet and reminds the user to go to bed";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
        Timer = {
          Unit = "${service-name}.service";
          OnCalendar = "Mon..Thu,Sun 21:00";
        };
      };
    };
  };
}
