{
  description = "Home Manager configuration of rapidfsub";

  inputs =
    {
      # Specify the source of Home Manager and Nixpkgs.
      nixpkgs = {
        url = "github:nixos/nixpkgs?ref=3d7dbcfb56a1cff0729280da3f1185044628975b";
      };
      flake-utils.url = "github:numtide/flake-utils";
      nix-darwin = {
        url = "github:LnL7/nix-darwin?ref=74ab0227ee495e526f2dd57ea684b34f6396445a";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager?ref=85c3b600f660abd86e94cbcd1c46733943197a07";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions?ref=e792da69b3af0431a2c33907866648198d59515f";
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
        rapidfsub = {
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
              "vscode-insiders"
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
    mergeAttrs darwinConfigurations homeConfigurations;
}
