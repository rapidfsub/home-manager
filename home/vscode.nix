{ vscode-marketplace, pkgs, system, ... }:

let
  inherit (builtins) fromJSON fromTOML map readFile;
  inherit (pkgs.lib.attrsets) getAttrFromPath;
  inherit (pkgs.lib.strings) splitString toLower;

  keybindings = fromJSON (readFile ./vscode/keybindings.json);
  extensions = fromTOML (readFile ./vscode/extensions.toml);
  userSettings = fromJSON (readFile ../.vscode/settings.json);

  getPackage = id: getAttrFromPath (splitString "." (toLower id)) vscode-marketplace;
in
{
  programs.vscode = {
    inherit keybindings;
    inherit userSettings;

    enable = true;
    enableExtensionUpdateCheck = false;
    extensions = map getPackage extensions.recommendations;
  };
}
