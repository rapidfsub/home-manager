{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file = {
    "init.lua" = {
      source = ./.config/nvim/init.lua;
      target = ".config/nvim/init.lua";
    };
  };
}
