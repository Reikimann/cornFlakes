{
  description = "Home Manager configuration of reikimann";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
      	inherit system;
	config = {
	  allowUnfree = true;
	};
      };
      lib = nixpkgs.lib;
    in {
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
