self: super: {
  niv =
    if (super.lib.versionAtLeast super.haskellPackages.niv.version "0.2.1")
    then super.haskellPackages.niv
    else (import (import ../nix/sources.nix).niv {}).niv;
}
