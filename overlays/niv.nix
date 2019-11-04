self: super: with super; {
  niv =
    if (lib.versionAtLeast haskellPackages.niv.version "0.2.1")
    then haskellPackages.niv
    else (import (import ../nix/sources.nix).niv {}).niv;
}
