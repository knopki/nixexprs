with {
  src = (import ../nix/sources.nix).nixpkgs-fmt;
};
self: super: with super; {
  nixpkgs-fmt =
    if (lib.versionAtLeast nixpkgs-fmt.version "0.6.0")
    then nixpkgs-fmt
    else nixpkgs-fmt.overrideAttrs (
      o: rec {
        inherit src;
        inherit (src) version;
      }
    );
}
