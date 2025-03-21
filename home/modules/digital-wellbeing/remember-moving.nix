{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.digital-wellbeing.remember-moving;
  service-name = "remember-moving";
  description = "Reminds the user to stand up and stretch";
in
{
  options.reiki.modules.digital-wellbeing.${service-name} = {
    enable = mkEnableOption "Remember moving";
    description = "${description}";
  };

  config = mkIf cfg.enable {
    systemd.user = {
      services.${service-name} = {
        Unit = {
          Description = "${description}";
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.writeShellScript "${service-name}" ''
            ${pkgs.libnotify}/bin/notify-send "Reminder" "Remember to stand up and stretch ;)"
          ''}";
        };
      };

      timers.${service-name} = {
        Unit = {
          Description = "${description}";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
        Timer = {
          Unit = "${service-name}.service";
          OnCalendar = "*:00/30:00";
        };
      };
    };
  };
}
