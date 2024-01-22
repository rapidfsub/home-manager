{ vscode-marketplace, pkgs, system, ... }:

let
  inherit (builtins) fetchTarball map;
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
    package = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      src = (fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=darwin-universal";
        sha256 = "1j33g5c2hjcgbdk7s9607g9ap7v0h6lpdsg51xwd80wsf3hr93d9";
      });
      version = "latest";

      buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
    });
    userSettings = importJSON ../.vscode/settings.json;
    globalSnippets = {
      liveview = importJSON ./.config/vscode/liveview.code-snippets;
      surface = importJSON ./.config/vscode/surface.code-snippets;
    };
  };
}
