{
  description = "Home Manager configuration of reikimann";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = import ./nix/config.nix;
      };
      lib = nixpkgs.lib;
    in {

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
          modules = [ ./hosts/braize/configuration.nix ];
        };
      };

      homeConfigurations = {
        reikimann = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # NOTE: ./home/modules : /modules may need to be removed to EdenEast/nyx how he handles it (regarding profiles)
          modules = [ ./hosts/braize/home.nix ./home/modules ];
          extraSpecialArgs = { inherit outputs; };
        };
      };
    };
}
