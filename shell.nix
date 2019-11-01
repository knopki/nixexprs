{ pkgs ? import <nixpkgs> {}, sources ? import ./nix/sources.nix }:
with pkgs.lib;
let
  overlays = import ./overlays;
  niv = (overlays.niv pkgs pkgs).niv;
  # until 20.03 try to use unstable or upstream version
  nixpkgs-fmt = if (hasPrefix "0.6." pkgs.nixpkgs-fmt.version) then pkgs.nixpkgs-fmt else if (hasAttrByPath [ "unstable" "nixpkgs-fmt" ] pkgs) then pkgs.unstable.nixpkgs-fmt else (import sources.nixpkgs-fmt {});
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
