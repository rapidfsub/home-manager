# asdf
# https://gist.github.com/axelbdt/0de9f5f9ba8a2100326b793f7bfb8658
. "$HOME/.nix-profile/share/asdf-vm/asdf.sh"

# erlang
NIX_PROFILE=$HOME/.nix-profile
SSL=$(nix eval --impure --expr 'builtins.toString (with (import <nixpkgs> {}); lib.getOutput "out" openssl)')
SSL_INCL=$(nix eval --impure --expr 'builtins.toString (with (import <nixpkgs> {}); lib.getDev openssl)')
export KERL_BUILD_DOCS=yes
export KERL_CONFIGURE_OPTIONS="--with-odbc=$NIX_PROFILE --with-ssl=$SSL --with-ssl-incl=$SSL_INCL --disable-jit"
export CC="/usr/bin/gcc -I$NIX_PROFILE/include"
export LDFLAGS="-L$NIX_PROFILE/lib"
