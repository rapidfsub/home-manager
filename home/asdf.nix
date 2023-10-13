{ pkgx, ... }:

let
  inherit (pkgx.lib) getDev getOutput;

  odbc-out = getOutput "out" pkgx.unixODBC;
  ssl-out = getOutput "out" pkgx.openssl;
  ssl-dev = getDev pkgx.openssl;
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
      asdf plugin add erlang
      KERL_CONFIGURE_OPTIONS="--with-odbc=${odbc-out} --with-ssl=${ssl-out} --with-ssl-incl=${ssl-dev} --disable-jit" \
        ASDF_KERL_VERSION="3.1.0" \
        KERL_BUILD_DOCS=yes \
        CFLAGS="-I${odbc-out}/include -O2" \
        LDFLAGS="-L${odbc-out}/lib" \
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
