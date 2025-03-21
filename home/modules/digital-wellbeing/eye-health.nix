{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.digital-wellbeing.eye-health;
  service-name = "eye-health";
  description = "Reminds the user to look away from the screen";
  remember-moving = config.reiki.modules.digital-wellbeing.remember-moving;
in
{
  options.reiki.modules.digital-wellbeing.${service-name} = {
    enable = mkEnableOption "Eye health";
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
            ${pkgs.libnotify}/bin/notify-send "Reminder" "Remember to look away from the screen ;)"
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
          OnCalendar = (if remember-moving.enable
            then "*:15,45:00" else "*:00/15:00");
        };
      };
    };
  };
}
