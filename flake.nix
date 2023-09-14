{
  description = "Home Manager configuration of rapidfsub";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      inherit (builtins) elem;
      inherit (nixpkgs.lib) getName;

      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: elem (getName pkg) [
          "vscode"
        ];
      };
    in
    {
      homeConfigurations."rapidfsub" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#rapidfsub-2017
      darwinConfigurations."rapidfsub-2017" = nix-darwin.lib.darwinSystem {
        inherit pkgs;

        modules = [ ./configuration.nix ];

        specialArgs = {
          root = self;
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."rapidfsub-2017".pkgs;
    };
}
