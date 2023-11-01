{ ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "exercism"
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
      "figma"
      "karabiner-elements"
      "keka"
      "logseq"
      "macs-fan-control"
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
      "livebook"
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
    global = {
      autoUpdate = true;
    };
  };
}
