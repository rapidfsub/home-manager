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
      "figma"
      "gimp"
      "karabiner-elements"
      "keka"
      "logseq"
      "macs-fan-control"
      "raycast"
      "scroll-reverser"
      "setapp"
      "slack"
      # browser
      "arc"
      "brave-browser"
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
      PolarisOffice = 1098211970;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    global = {
      autoUpdate = true;
    };
  };
}
