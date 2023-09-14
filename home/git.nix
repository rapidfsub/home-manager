{ ... }:

{
  home.file = {
    ".config/git/aidkr.inc" = {
      source = ./.config/git/aidkr.inc;
      target = ".config/git/aidkr.inc";
    };

    ".config/git/default.inc" = {
      source = ./.config/git/default.inc;
      target = ".config/git/default.inc";
    };
  };

  programs.git = {
    enable = true;
    extraConfig = {
      include = {
        path = "./default.inc";
      };
      includeIf = {
        "gitdir:~/aidkr/" = {
          path = "./aidkr.inc";
        };
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
    };
  };
}
