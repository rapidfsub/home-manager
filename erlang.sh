#!/bin/zsh
NIX_PROFILE=$HOME/.nix-profile
SSL=$(nix eval --impure --expr 'builtins.toString (with (import <nixpkgs> {}); lib.getOutput "out" openssl)')
SSL_INCL=$(nix eval --impure --expr 'builtins.toString (with (import <nixpkgs> {}); lib.getDev openssl)')

asdf plugin add erlang

KERL_BUILD_DOCS=yes \
  KERL_CONFIGURE_OPTIONS="--with-odbc=$NIX_PROFILE --with-ssl=$SSL --with-ssl-incl=$SSL_INCL --disable-jit" \
  CC="/usr/bin/gcc -I$NIX_PROFILE/include" \
  LDFLAGS="-L$NIX_PROFILE/lib" \
  asdf install erlang
