{
  description = "Home Manager configuration of reikimann";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = import ./nix/config.nix;
        overlays = self.overlays;
      };
      lib = nixpkgs.lib;
    in {

      # https://github.com/EdenEast/nyx/blob/0da99bed4058d655e1b11a3bfe68c9c9d0222e46/flake.nix#L67C18-L67C31
      #pkgsOverlay = [ (import ./nix/pkgs).overlay ];
      pkgsOverlay = import ./nix/pkgs { inherit pkgs; };
      overlays = let
          #ovs = lib.attrValues (import ./nix/overlays self);
          ovs = (import ./nix/overlays);
        in
        [
          (self.pkgsOverlay)
        ] ++ ovs;

      nixosConfigurations = {
        braize = lib.nixosSystem {
          system = system;
          modules = [ ./hosts/braize/configuration.nix ];
        };
      };

      homeConfigurations = {
        reikimann = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./home.nix ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    };
}

# Why default package? this was needed when on Arch.
#{
#  outputs = { self, nixpkgs, home-manager, ... }:
#    in {
#      defaultPackage.${system} =
#        home-manager.defaultPackage.${system};
#}
