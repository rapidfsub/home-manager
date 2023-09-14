{ pkgs, root, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "openssl"
      "mas"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
    ];
    casks = [
      "firefox"
      "font-fantasque-sans-mono-nerd-font"
      "karabiner-elements"
      "macs-fan-control"
      "microsoft-teams"
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
