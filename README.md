
## Structure

TODO: Finish this
- `nix/` - Nix package manager configurations
  - `overlays/` - Nix overlays
  - `pkgs/` - Self packaged applications

## Modules
config.reiki.modules.module-type.program-name
config.reiki.profiles.[common,work,development,gaming]

REMEMBER a laptop option

## TODO

### Nix
- [ ] Convert every dotfile to be managed by nix
- [ ] Add a module system
    - [ ] Home-manager
        - [X] Programs
            - [X] Sort the default.nix files
        - [X] Services
        - [X] Shell
        - [X] Editors
        - [X] Cli
        - [X] Development
        - [ ] Desktops
    - [ ] System
    - https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/module-system
    - Example: https://github.com/EdenEast/nyx/blob/0da99bed4058d655e1b11a3bfe68c9c9d0222e46/home/modules/shell/xdg.nix
- [ ] Add profiles and maybe archetypes (librephoenix/nixos-config)
    - [ ] To home-manager in /home/profiles/
    - [ ] To NixOS in /system/profiles/
- [ ] Can I add a getPrimaryMonitor function to the monitors module (see waybar)
- [ ] Checkout config.lib.file.mkOutOfStoreSymlink (for nvim, emacs and other configs not managed through nix module settings)
- [ ] Configure firefox search engines with modules
- [ ] Properly add ungoogled-chromium so that it isn't opened by other programs
- [ ] Can I use the flakes self to do absolute imports? How to better handle paths
- [ ] Setup garbage collection
- [ ] After NixOS installation on laptop add makeUserHome and mkHome functions to lib (see EdenEast/nyx)
- [ ] Checkout nix-output-manager
- [ ] Reorder the home-manager modules into a better system:
    - "The cleanest I have seen were concern-based categories (e.g. desktop-environment.nix, development-tools.nix…), rather than grouping by type (e.g. services.nix, programs.nix…)."
- Wayland:
    - https://wiki.nixos.org/wiki/Wayland
### Nvim
- [ ] Setup blink.cmp

## Host Specifications
| Name          | Description                                         |  Type   |     Arch      |
| :-----------: | :-------------------------------------------------: | :-----: | :-----------: |
| `Braize`      | Day-to-day desktop workstation and gaming machine.  | Desktop | x86_64-linux  |
| not yet named | Lenovo work laptop for work, school and programming | Laptop  | x86_64-linux  |
