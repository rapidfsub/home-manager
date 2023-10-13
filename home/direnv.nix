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

    "aidkr/.envrc" = {
      source = ./aidkr/.envrc;
      target = "aidkr/.envrc";
    };
  };

  programs.direnv = {
    enable = true;
    stdlib = readFile ./.config/direnv/direnvrc;
    nix-direnv.enable = true;
  };
}
