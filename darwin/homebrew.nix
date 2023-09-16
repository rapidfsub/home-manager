{ pkgs, root, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    # brew tap
    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
    ];
    casks = [
      "docker"
      "firefox"
      "font-fantasque-sans-mono-nerd-font"
      "google-chrome"
      "karabiner-elements"
      "macs-fan-control"
      "microsoft-teams"
      "pgadmin4"
      "raycast"
      "scroll-reverser"
      "setapp"
      "warp"
    ];
    masApps = {
      KakaoTalk = 869223134;
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
