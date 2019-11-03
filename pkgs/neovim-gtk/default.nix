{ sources, stdenv, rustPlatform, gtk3, gnome3, wrapGAppsHook, ... }:
let
  src = sources.neovim-gtk;
in
rustPlatform.buildRustPackage rec {
  inherit src;
  inherit (src) version cargoSha256;
  name = "neovim-gtk-unstable-${version}";

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = [ gtk3 gnome3.vte ];

  meta = with stdenv.lib; {
    inherit (src) description homepage;
    license = with licenses; [ gpl3 ];
    platforms = platforms.linux;
  };
}
