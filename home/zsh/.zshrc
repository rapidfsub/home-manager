# asdf
# https://gist.github.com/axelbdt/0de9f5f9ba8a2100326b793f7bfb8658
. "$HOME/.nix-profile/share/asdf-vm/asdf.sh"

# erlang
unixodbc=$(nix path-info nixpkgs#unixODBC)
export KERL_BUILD_DOCS=yes
export KERL_CONFIGURE_OPTIONS="--with-odbc=$unixodbc --disable-jit"
export CC="/usr/bin/gcc -I$unixodbc/include"
export LDFLAGS="-L$unixodbc/lib"
