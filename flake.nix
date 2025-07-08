{
  description = "Home Manager configuration of reikimann";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    NixOS-WSL.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, NixOS-WSL, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = import ./nix/config.nix;
      };
      lib = nixpkgs.lib;
    in {
      defaultPackage.${system} =
        home-manager.defaultPackage.${system};

      # https://github.com/EdenEast/nyx/blob/0da99bed4058d655e1b11a3bfe68c9c9d0222e46/flake.nix#L67C18-L67C31
      #pkgsOverlay = [ (import ./nix/pkgs).overlay ];
      #pkgsOverlay = import ./nix/pkgs { inherit pkgs; };
      legacyPackages = pkgs;
      packages = import ./nix/pkgs { inherit pkgs; };
      overlay = _final: _prev: self.packages;
      overlays = let
          #ovs = lib.attrValues (import ./nix/overlays self);
          ovs = (import ./nix/overlays);
        in
        [
          (self.overlay)
        ] ++ ovs;

      formatter.${system} = pkgs.nixfmt-rfc-style;

      nixosConfigurations = {
        braize = lib.nixosSystem {
          specialArgs = { inherit outputs; };
          system = system;
          modules = [ ./hosts/braize ];
        };
        scadrial = lib.nixosSystem {
          specialArgs = { inherit outputs; };
          system = system;
          modules = [ ./hosts/scadrial ];
        };
        nalthis = lib.nixosSystem {
          specialArgs = { inherit outputs; };
          system = system;
          modules = [ 
	    ./hosts/nalthis
	    NixOS-WSL.nixosModules.wsl
	  ];
        };
      };

      homeConfigurations = {
        "reikimann@braize" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # NOTE: ./home/modules : /modules may need to be removed to EdenEast/nyx how he handles it (regarding profiles)
          modules = [ ./hosts/braize/home.nix ./home/modules ./home/profiles ];
          extraSpecialArgs = { inherit outputs inputs; };
        };
        "reikimann@scadrial" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/scadrial/home.nix ./home/modules ./home/profiles ];
          extraSpecialArgs = { inherit outputs inputs; };
        };
        "reikimann@nalthis" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/nalthis/home.nix ./home/modules ./home/profiles ];
          extraSpecialArgs = { inherit outputs inputs; };
        };
      };
    };
}
