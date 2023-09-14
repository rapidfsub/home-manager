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
      inherit (builtins) elem;
      inherit (nixpkgs.lib) getName;
      inherit (flake-utils.lib.system) x86_64-darwin;

      system = x86_64-darwin;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: elem (getName pkg) [
          "vscode"
        ];
      };
      vscode-marketplace = vscode-extensions.extensions.${system}.vscode-marketplace;
    in
    {
      homeConfigurations."rapidfsub" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit vscode-marketplace;
        };
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
