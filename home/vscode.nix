{ vscode-marketplace, pkgs, system, ... }:

let
  inherit (builtins) map;
  inherit (pkgs.lib.attrsets) getAttrFromPath;
  inherit (pkgs.lib.strings) splitString toLower;
  inherit (pkgs.lib.trivial) importJSON importTOML mergeAttrs;

  extensions = importTOML ./.config/vscode/extensions.toml;
  getPackage = id: getAttrFromPath (splitString "." (toLower id)) vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    extensions = map getPackage extensions.recommendations;
    keybindings = importJSON ./.config/vscode/keybindings.json;
    userSettings = importJSON ../.vscode/settings.json;
    globalSnippets = {
      liveview = importJSON ./.config/vscode/liveview.code-snippets;
      surface = importJSON ./.config/vscode/surface.code-snippets;
    };
  };
}
