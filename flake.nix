{
  description = "Home Manager configuration of rapidfsub";

  inputs =
    {
      # Specify the source of Home Manager and Nixpkgs.
      nixpkgs = {
        url = "github:nixos/nixpkgs?ref=8b5ab8341e33322e5b66fb46ce23d724050f6606";
      };
      flake-utils.url = "github:numtide/flake-utils";
      nix-darwin = {
        url = "github:LnL7/nix-darwin?ref=afeddc412b3a3b0e7c9ef7ea5fbdf2186781d102";
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

      pkgx = import nixpkgs {
        system = x86_64-darwin;
      };

      machines = {
        rapidfsub-2017 = {
          system = x86_64-darwin;
        };
        rapidfsub-2021 = {
          system = aarch64-darwin;
        };
        spark = {
          system = aarch64-darwin;
        };
      };

      users = {
        rxpidfsub = {
          system = x86_64-darwin;
        };
        rapidfsub-2021 = {
          system = aarch64-darwin;
        };
        spark = {
          system = aarch64-darwin;
        };
      };

      darwinConfigurations = eachSystem (attrNames machines) (name:
        let
          machine = machines.${name};
          pkgs = import nixpkgs {
            system = machine.system;
          };
        in
        {
          # Build darwin flake using:
          # $ darwin-rebuild build --flake .#rapidfsub-2017
          darwinConfigurations = nix-darwin.lib.darwinSystem {
            pkgs = pkgs;

            modules = [ ./configuration.nix ];

            specialArgs = {
              hostPlatform = machine.system;
              rev = nix-darwin.rev;
            };
          };
        });

      homeConfigurations = eachSystem (attrNames users) (username:
        let
          user = users.${username};
          pkgs = import nixpkgs {
            system = user.system;
            config.allowUnfreePredicate = pkg: elem (getName pkg) [
              "vscode"
            ];
          };
          vscode-marketplace = vscode-extensions.extensions.${user.system}.vscode-marketplace;
        in
        {
          homeConfigurations = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = {
              inherit pkgx;
              inherit username;
              inherit vscode-marketplace;
            };
          };
        });
    in
    mergeAttrs (mergeAttrs darwinConfigurations homeConfigurations) {
      # Expose the package set, including overlays, for convenience.
      darwinPackages = pkgx;
    };
}
