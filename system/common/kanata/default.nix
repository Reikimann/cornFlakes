{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kanata
  ];

  # Can this be made into a module?
  users.groups.uinput = {}; # Uinput for kanata
  users.users.reikimann = {
    extraGroups = [ "input" "uinput" ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        configFile = ./config.kbd;
      };
    };
  };
}
