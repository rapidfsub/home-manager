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
    envExtra = readFile ./zsh/.zshenv;
    history = {
      ignoreDups = true;
    };
    initExtra = readFile ./zsh/.zshrc;
    profileExtra = readFile ./zsh/.zprofile;
  };
}
