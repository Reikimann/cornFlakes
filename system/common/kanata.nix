{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kanata
  ];

  # Can this be made into a module?
  # users.groups.uinput = {}; # Uinput for kanata
  # users.users.reikimann = {
  #   extraGroups = [ "input" "uinput" ];
  # };

  services.kanata = {
    enable = true;
    keyboards = {
      logitechKeyboard = {
        #devices = [ "/dev/input/by-id/usb-Logitech_Gaming_Keyboard_G910_0A7234663735-event-kbd" ];
        configFile = ./config.kbd;
      };
    };
  };
}
