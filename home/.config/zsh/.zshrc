# asdf
# https://gist.github.com/axelbdt/0de9f5f9ba8a2100326b793f7bfb8658
. "$HOME/.nix-profile/share/asdf-vm/asdf.sh"
. ~/.asdf/plugins/java/set-java-home.zsh

# brew
if [[ $(arch) == "arm64" ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH"
else
  export PATH="/usr/local/bin:/usr/local/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi
