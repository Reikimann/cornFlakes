{ pkgs, ... }:

{
  # NixOS-WSL specific options are documented on the NixOS-WSL repository:
  # https://github.com/nix-community/NixOS-WSL
  imports = [
    ../../system/common
  ];

  wsl = {
    enable = true;
    startMenuLaunchers = true;
    defaultUser = "reikimann";
  };

  # Hostname-scheme is Cosmere planets
  networking.hostName = "nalthis"; # Define your hostname.

  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_CTYPE="en_DK.UTF-8";
      LC_ADDRESS = "en_DK.UTF-8";
      LC_IDENTIFICATION = "en_DK.UTF-8";
      LC_MEASUREMENT = "en_DK.UTF-8";
      LC_MONETARY = "en_DK.UTF-8";
      LC_NAME = "en_DK.UTF-8";
      LC_NUMERIC = "en_DK.UTF-8";
      LC_PAPER = "en_DK.UTF-8";
      LC_TELEPHONE = "en_DK.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };

  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure console keymap
  console.useXkbConfig = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.reikimann = {
    isNormalUser = true;
    description = "reikimann";
    initialPassword = "NixOS";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    #packages = with pkgs; [ ];
  };

  fonts.packages = with pkgs; [
    sf-mono-liga-bin
 ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim

    kitty

    libsecret
    adwaita-icon-theme

    imagemagick
    git
    wl-clipboard
    wev
    nemo
  ];

  hardware.keyboard.qmk.enable = true;

  # enabling OpenGL
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read (man configuration.nix or https://nixos.org/nixos/options.html)
  system.stateVersion = "24.05";
}
