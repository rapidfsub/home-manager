{ pkgx, ... }:

let
  inherit (pkgx.lib) getDev getOutput;
in
{
  home.packages = with pkgx; [
    # asdf
    asdf-vm
    # erlang
    fop
    jdk
    openssl
    unixODBC
    wxGTK32
    (writeShellScriptBin "install-erlang.sh" ''
      ODBC=${getOutput "out" unixODBC}
      SSL=${getOutput "out" openssl}
      SSL_INCL=${getDev openssl}

      asdf plugin add erlang

      KERL_BUILD_DOCS=yes \
        KERL_CONFIGURE_OPTIONS="--with-odbc=$ODBC --with-ssl=$SSL --with-ssl-incl=$SSL_INCL --disable-jit" \
        CFLAGS="-I$ODBC/include -O2" \
        LDFLAGS="-L$ODBC/lib" \
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
