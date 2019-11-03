{ pkgs, sources }:
with pkgs; let
  nixfromnpm = sources.nixfromnpm;
in
(import "${nixfromnpm}/release.nix" {}).nixfromnpm
