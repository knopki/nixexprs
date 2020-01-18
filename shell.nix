{ sources ? import ./nix/sources.nix }:
let
  unstable = import sources.nixpkgs-unstable {};
  pkgs = import sources.nixpkgs {
    overlays = [
      (
        self: super: {
          nixpkgs-fmt = unstable.nixpkgs-fmt;
        }
      )
    ];
  };
  overlays = (import ./overlays).allOverlays pkgs pkgs;
  myPkgs = pkgs.callPackage ./pkgs { inherit sources; };
  nixfromnpm = myPkgs.nixfromnpm;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # essential
    direnv
    gitAndTools.pre-commit
    haskellPackages.niv
    nixpkgs-fmt
    stdenv

    # add-when-needed: manual cachix push
    # cachix

    # add-when-needed: Go packaging
    # dep2nix
    # vgo2nix

    # add-when-needed Node packaging
    # nixfromnpm
  ];
}
