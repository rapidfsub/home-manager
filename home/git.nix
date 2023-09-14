{ ... }:

{
  programs.git = {
    enable = true;
    userEmail = "rapidfsub@gmail.com";
    userName = "Minsub Kim";
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
