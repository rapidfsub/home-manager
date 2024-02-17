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
      "linearmouse"
      "logseq"
      "macs-fan-control"
      "raycast"
      "rectangle"
      "setapp"
      "slack"
      "zoom"
      # browser
      "arc"
      "brave-browser"
      "firefox"
      "google-chrome"
      "tor-browser"
      # dev
      "docker"
      "gitbutler"
      "iterm2"
      "livebook"
      "pgadmin4"
      "postman"
      # font
      "font-fantasque-sans-mono-nerd-font"
    ];
    masApps = {
      Bitwarden = 1352778147;
      HotKey = 975890633;
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
