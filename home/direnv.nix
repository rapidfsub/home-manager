{ ... }:

let
  inherit (builtins) readFile;
in
{
  home.file = {
    "fireworks/.envrc" = {
      source = ./fireworks/.envrc;
      target = "fireworks/.envrc";
    };

    "devall/.envrc" = {
      source = ./devall/.envrc;
      target = "devall/.envrc";
    };
  };

  programs.direnv = {
    enable = true;
    stdlib = readFile ./.config/direnv/direnvrc;
    nix-direnv.enable = true;
  };
}
