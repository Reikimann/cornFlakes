# cornFlakes


## Structure

- `nix/` - Nix package manager configurations
  - `overlays/` - Nix overlays
  - `pkgs/` - Self packaged applications

## TODO

- [ ] Convert every dotfile to be managed by nix
- [ ] Add profiles
    - [ ] To home-manager in /home/profiles/
    - [ ] To NixOS in /system/profiles/
- [ ] Add home-manager/hosts
- [ ] Add a module system
    - https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/module-system
    - Example: https://github.com/EdenEast/nyx/blob/0da99bed4058d655e1b11a3bfe68c9c9d0222e46/home/modules/shell/xdg.nix
- [ ] Checkout nix-output-manager
- Wayland:
    - environment.sessionVariables.NIXOS_OZONE_WL = "1";
    - https://wiki.nixos.org/wiki/Wayland
