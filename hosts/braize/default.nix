{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/common
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    #kernelParams = [
    #  "quiet"
    #];
  };

  # Hostname-scheme is Cosmere planets
  networking.hostName = "braize"; # Define your hostname.
  networking.networkmanager.enable = true;

  networking.networkmanager.dns = "none"; # https://networkmanager.dev/docs/api/latest/NetworkManager.conf.html
  networking.nameservers = [
    "192.168.1.17"
    #"192.168.1.1"
  ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Enable the X11 windowing system.
  # NOTE: Do I even need this anymore, now that I dont use x11?
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  # TODO: Make this into a module and make it toggleable
  security.pam.services.swaylock = { };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "winkeys";
    options = "ctrl:swapcaps";
  };

  # Configure console keymap
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "input" "docker" ];
    #packages = with pkgs; [ ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim

    libsecret
    adwaita-icon-theme

    imagemagick
    git
    wl-clipboard
    libnotify
    wlr-randr
    wev
    nemo

    qmk
    vial
  ];

  services.udev.packages = [ pkgs.vial ];
  hardware.keyboard.qmk.enable = true;

  virtualisation.docker.enable = true;

  # enabling OpenGL and GPU drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia.modesetting.enable = true;
    nvidia.open = false;
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
