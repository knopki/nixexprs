{ pkgs ? import <nixpkgs> {}, sources ? import ./nix/sources.nix }:
with pkgs.lib;
let
  overlays = (import ./overlays).allOverlays pkgs pkgs;
  niv = overlays.niv;
  nixpkgs-fmt = overlays.nixpkgs-fmt;
  myPkgs = pkgs.callPackage ./pkgs { inherit sources; };
  nixfromnpm = myPkgs.nixfromnpm;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    # essential
    direnv
    gitAndTools.pre-commit
    niv
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
