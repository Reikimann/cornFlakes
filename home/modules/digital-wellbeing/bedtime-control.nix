{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.digital-wellbeing.bedtime-control;

  service-name = "bedtime-control";
  description = "Disables the internet and reminds the user to go to bed";

  service-name-disable = "${service-name}-disable";
  description-disable = "Re-enables the internet";
in
{
  options.reiki.modules.digital-wellbeing.${service-name} = {
    enable = mkEnableOption "Bedtime control";
    description = "${description}";
  };

  config = mkIf cfg.enable {
    systemd.user = {
      services = {
        ${service-name} = {
          Unit = {
            Description = "${description}";
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

        ${service-name-disable} = {
          Unit = {
            Description = "${description-disable}";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.networkmanager}/bin/nmcli networking on";
          };
        };
      };

      timers = {
        ${service-name} = {
          Unit = {
            Description = "${description}";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
          Timer = {
            Unit = "${service-name}.service";
            OnCalendar = "Mon..Thu,Sun 21:00";
          };
        };

        ${service-name-disable} = {
          Unit = {
            Description = "${description-disable}";
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
          Timer = {
            Unit = "${service-name-disable}.service";
            OnCalendar = "Mon..Fri 06:00";
            Persistent = true;
          };
        };
      };
    };
  };
}
