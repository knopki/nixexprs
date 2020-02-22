{ pkgs, sources, stdenv, rustPlatform, gtk3, gnome3, wrapGAppsHook, ... }:
let
  src = sources.neovim-gtk;
in
rustPlatform.buildRustPackage rec {
  inherit src;
  inherit (src) version;
  name = "neovim-gtk-unstable-${version}";
  cargoSha256 = if pkgs.cargo.version == "1.37.0" then src.cargoSha256 else src.cargoSha256_unstable;

  nativeBuildInputs = [ wrapGAppsHook ];
  buildInputs = [ gtk3 gnome3.vte ];

  meta = with stdenv.lib; {
    inherit (src) description homepage;
    license = with licenses; [ gpl3 ];
    platforms = platforms.linux;
  };
}
