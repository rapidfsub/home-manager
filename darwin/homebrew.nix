{ pkgs, root, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "flyctl"
      "mackup"
      "mas"
    ];
    # brew tap
    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
    ];
    casks = [
      "asana"
      "karabiner-elements"
      "logseq"
      "macs-fan-control"
      "microsoft-teams"
      "raycast"
      "scroll-reverser"
      "setapp"
      "slack"
      # browser
      "firefox"
      "google-chrome"
      # dev
      "docker"
      "iterm2"
      "pgadmin4"
      "postman"
      "warp"
      # font
      "font-fantasque-sans-mono-nerd-font"
    ];
    masApps = {
      KakaoTalk = 869223134;
    };
    onActivation = {
      cleanup = "zap";
    };
  };
}
