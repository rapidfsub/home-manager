{ pkgs, ... }:

let
  inherit (pkgs.lib) getDev getOutput;
in
{
  home.packages = with pkgs; [
    # asdf
    asdf-vm
    # erlang
    fop
    jdk
    openssl
    unixODBC
    wxGTK32
    (writeShellScriptBin "install-erlang.sh" ''
      NIX_PROFILE=$HOME/.nix-profile
      SSL=${getOutput "out" openssl}
      SSL_INCL=${getDev openssl}

      asdf plugin add erlang

      KERL_BUILD_DOCS=yes \
        KERL_CONFIGURE_OPTIONS="--with-odbc=$NIX_PROFILE --with-ssl=$SSL --with-ssl-incl=$SSL_INCL --disable-jit" \
        CC="/usr/bin/gcc -I$NIX_PROFILE/include" \
        LDFLAGS="-L$NIX_PROFILE/lib" \
        asdf install erlang
    '')
  ];

  home.file = {
    ".tool-versions" = {
      source = ./.config/asdf/.tool-versions;
      target = ".tool-versions";
    };
  };
}
