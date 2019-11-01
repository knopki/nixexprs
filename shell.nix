{ pkgs ? import <nixpkgs> {}, sources ? import ./nix/sources.nix }:
with pkgs.lib;
let
  overlays = import ./overlays;
  niv = (overlays.niv pkgs pkgs).niv;
  nixpkgs-fmt = (overlays.nixpkgs-fmt pkgs pkgs).nixpkgs-fmt;
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    dep2nix
    direnv
    gitAndTools.pre-commit
    niv
    nixpkgs-fmt
    stdenv
    vgo2nix
  ];
}
