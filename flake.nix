{
  description = "Home Manager configuration of rapidfsub";

  inputs =
    {
      # Specify the source of Home Manager and Nixpkgs.
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
      nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager?ref=b62f549653e97d78392c1e282b8ca76546a86585";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions?ref=99fe4360baadb636d40f00995a25d3f2fdc50097";
      };
    };

  outputs = { self, nixpkgs, flake-utils, nix-darwin, home-manager, vscode-extensions, ... }:
    let
      inherit (builtins) attrNames elem;
      inherit (nixpkgs.lib) getName;
      inherit (nixpkgs.lib.trivial) mergeAttrs;
      inherit (flake-utils.lib) eachSystem;
      inherit (flake-utils.lib.system) aarch64-darwin x86_64-darwin;

      pkgx = import nixpkgs { system = x86_64-darwin; };
      pkgs = import nixpkgs { system = aarch64-darwin; };

      machines = {
        rapidfsub-2017 = {
          system = x86_64-darwin;
          pkgs = pkgx;
        };
      };

      users = {
        rapidfsub = rec {
          system = x86_64-darwin;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg: elem (getName pkg) [
              "vscode"
            ];
          };
        };
      };

      darwinConfigurations = eachSystem (attrNames machines) (name:
        let
          machine = machines.${name};
        in
        {
          # Build darwin flake using:
          # $ darwin-rebuild build --flake .#rapidfsub-2017
          darwinConfigurations = nix-darwin.lib.darwinSystem {
            pkgs = machine.pkgs;

            modules = [ ./configuration.nix ];

            specialArgs = {
              hostPlatform = machine.system;
              root = self;
            };
          };
        });

      homeConfigurations = eachSystem (attrNames users) (name:
        let
          user = users.${name};
          vscode-marketplace = vscode-extensions.extensions.${user.system}.vscode-marketplace;
        in
        {
          homeConfigurations = home-manager.lib.homeManagerConfiguration {
            pkgs = user.pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = {
              inherit vscode-marketplace;
            };
          };
        });
    in
    mergeAttrs (mergeAttrs darwinConfigurations homeConfigurations) {
      # Expose the package set, including overlays, for convenience.
      darwinPackages = pkgs;
    };
}
