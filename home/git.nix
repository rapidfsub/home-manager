{ ... }:

{
  home.file = {
    ".config/git/devall.inc" = {
      source = ./.config/git/devall.inc;
      target = ".config/git/devall.inc";
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
        "gitdir:~/devall/" = {
          path = "./devall.inc";
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
