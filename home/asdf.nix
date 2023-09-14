{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # asdf
    asdf-vm
    # erlang
    fop
    jdk
    unixODBC
    wxGTK32
  ];

  home.file = {
    ".tool-versions" = {
      source = ./.config/asdf/.tool-versions;
      target = ".tool-versions";
    };
  };

  programs.zsh = {
    enable = true;
  };
}
