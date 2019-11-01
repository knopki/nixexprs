with {
  src = (import ../nix/sources.nix).morph;
};
self: super: {
  morph = super.morph.overrideAttrs (
    o: rec {
      inherit src;
      inherit (src) version;
    }
  );
}
