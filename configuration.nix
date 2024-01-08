# { config, lib, modulesPath, options, pkgs, specialArgs }:
{ hostPlatform, pkgs, rev, ... }:

{
  imports = [
    ./darwin/homebrew.nix
    ./darwin/system/defaults.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    home-manager
    rnix-lsp
    stack
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = rev;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = hostPlatform;

  environment = {
    shellAliases = {
      ds = "darwin-rebuild switch --flake ~/.config/home-manager";
      hs = ''
        mkdir -p ~/.local/state/nix/profiles && \
          home-manager switch --flake ~/.config/home-manager && \
          find $HOME/.vscode/extensions/* -depth 0 -type f | xargs rm && \
          find $HOME/.vscode/extensions/* -depth 0 -type d | xargs rm -rf
      '';
      mrf = ''
        pkill iTerm2 || \
          mackup restore -f
      '';
    };
  };

  programs.zsh = {
    promptInit = "";
  };
}
