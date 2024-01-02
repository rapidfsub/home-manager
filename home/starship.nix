{ ... }:

{
  home.file = {
    "starship.toml" = {
      source = ./.config/starship/starship.toml;
      target = ".config/starship.toml";
    };
  };
}
