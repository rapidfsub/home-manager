{ ... }:

let
  inherit (builtins) readFile;
in
{
  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "./.config/zsh";
    enableAutosuggestions = true;
    envExtra = readFile ./.config/zsh/.zshenv;
    history = {
      ignoreDups = true;
    };
    initExtra = readFile ./.config/zsh/.zshrc;
    profileExtra = readFile ./.config/zsh/.zprofile;
  };
}
