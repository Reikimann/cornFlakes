
## Structure

- `nix/` - Nix package manager configurations
  - `overlays/` - Nix overlays
  - `pkgs/` - Self packaged applications

### Modules
config.reiki.modules.module-type.program-name
config.reiki.profiles.[common,work,development,gaming]

REMEMBER a laptop option

## TODO

- [ ] Convert every dotfile to be managed by nix
- [ ] Add a module system
    - [ ] Home-manager
    - [ ] System
    - https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/module-system
    - Example: https://github.com/EdenEast/nyx/blob/0da99bed4058d655e1b11a3bfe68c9c9d0222e46/home/modules/shell/xdg.nix
- [ ] Add profiles
    - [ ] To home-manager in /home/profiles/
    - [ ] To NixOS in /system/profiles/
- [ ] Add ~home-manager/hosts~ home.nix files to /hosts/
- [ ] Setup garbage collection
- [ ] After NixOS installation on laptop add makeUserHome and mkHome functions to lib (see EdenEast/nyx)
- [ ] Checkout nix-output-manager
- [ ] Checkout config.lib.file.mkOutOfStoreSymlink
- Wayland:
    - https://wiki.nixos.org/wiki/Wayland

- "I prefer writeShellApplication over writeShellScriptBin. writeShellApplication also runs your shell script through shellcheck, great for people like me who write sloppy shell scripts. You can also specify runtime dependencies by doing runtimeInputs = [ cowsay ];, that way you can just write cowsay without having to reference the path to cowsay explicitly within the script :)"

## Host Specifications
| Name          | Description                                         |  Type   |     Arch      |
| :-----------: | :-------------------------------------------------: | :-----: | :-----------: |
| `Braize`      | Day-to-day desktop workstation and gaming machine.  | Desktop | x86_64-linux  |
| not yet named | Lenovo work laptop for work, school and programming | Laptop  | x86_64-linux  |
