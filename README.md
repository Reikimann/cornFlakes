## Structure
- [ ] Finish documenting the structure
- `nix/` - Nix package manager configurations
  - `overlays/` - Nix overlays
  - `pkgs/` - Self packaged applications

## TODO
### Nix
- [ ] Add a modules and profiles to the /system folder
    - [ ] Modules
    - [ ] Profiles
- [ ] Add a font module that defines fonts to be used in every app (does this already exist?)
    - https://github.com/Misterio77/nix-config/blob/7ede608b314eb4b59a588e1d7bfc644ccc409e0e/modules/home-manager/fonts.nix
- [ ] Setup garbage collection
- [ ] Checkout Lorri and dir-env
    - https://github.com/nix-community/lorri
- [ ] After NixOS installation on laptop add makeUserHome and mkHome functions to lib (see EdenEast/nyx)
- [ ] Make a nix module for chosing defaults like the main editor, terminal, browser, etc.
- [ ] Convert every dotfile to be managed by nix
- [ ] Configure firefox search engines with modules
- [ ] Properly add ungoogled-chromium so that it isn't opened by other programs
- [ ] Add Syncthing
- [ ] Fix suspend/sleep/wakeup issues: https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#programs-dont-work-in-systemd-services-but-do-on-the-terminal
- [ ] Reorder the home-manager modules into a better system:
    - "The cleanest I have seen were concern-based categories (e.g. desktop-environment.nix, development-tools.nix…), rather than grouping by type (e.g. services.nix, programs.nix…)."
- [ ] Checkout nix-output-manager
- Wayland:
    - https://wiki.nixos.org/wiki/Wayland

### Ricing
- [ ] Check out Astal/AGS (Aylur's GTK Shell) (cli)
    - [ ] https://aylur.github.io/ags/
    - [ ] (Outdated) https://www.youtube.com/watch?v=GvpTUKaXqNk
    - Keep an eye on Fabric widgets
        - Although it's not declarative widgets, so choose AGS
        - https://github.com/Fabric-Development/fabric
        - https://github.com/Axenide/dotfiles
- [ ] NixOS Stylix

### Nvim
- [ ] Setup blink.cmp
- [ ] Make the paste button from custom keyboard work

### Emacs
- [ ] https://www.reddit.com/r/emacs/comments/1hwvtyo/ultrascroll_v02_scroll_emacs_like_lightning


## Host Specifications
- [ ] Find a cosmere planet for `Superiority` when converting it to Nix.

| Name          | Description                                         |  Type   |     Arch      |
| :-----------: | :-------------------------------------------------: | :-----: | :-----------: |
| `Braize`      | Day-to-day desktop workstation and gaming machine.  | Desktop | x86_64-linux  |
| `Superiority` | Lenovo work laptop for work, school and programming | Laptop  | x86_64-linux  |
