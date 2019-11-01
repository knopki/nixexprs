with {
  src = (import ../nix/sources.nix).nixpkgs-fmt;
};
self: super: {
  nixpkgs-fmt =
    if (super.lib.versionAtLeast super.nixpkgs-fmt.version "0.6.0")
    then super.nixpkgs-fmt
    else super.nixpkgs-fmt.overrideAttrs (
      o: rec {
        inherit src;
        inherit (src) version;
      }
    );
}
