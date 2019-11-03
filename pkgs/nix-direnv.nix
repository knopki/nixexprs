{ lib, sources, stdenv }:
with lib;
let
  src = sources.nix-direnv;
in
stdenv.mkDerivation rec {
  inherit src;
  pname = "nix-direnv";
  version = src.rev;
  dontBuild = true;
  installPhase = ''
    mkdir -p $out
    cp -r ./direnvrc $out
  '';
  meta = {
    inherit (src) description homepage;
    license = licenses.mit;
    platform = platforms.all;
  };
}
