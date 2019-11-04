{ pkgs ? import <nixpkgs> {}, lib, newScope, recurseIntoAttrs, sources ? import ../nix/sources.nix, nodejs ? pkgs.nodejs }:
lib.makeScope newScope (
  self: with self; let
    callPackages = lib.callPackagesWith (pkgs // self // { inherit sources; });
    mkNodeLib = import ./nodeLib {
      self = mkNodeLib;
    };
    nodeLib = mkNodeLib {
      inherit pkgs nodejs;
    };
  in
    rec {
      fishPlugins = recurseIntoAttrs (callPackages ./fish-plugins {});
      lsColors = callPackages ./ls-colors.nix {};
      neovim-gtk = callPackages ./neovim-gtk {};
      nixfromnpm = callPackages ./nixfromnpm {};
      kube-score = callPackages ./kube-score {};
      kustomize1 = callPackages ./kustomize1 {};
      nix-direnv = callPackages ./nix-direnv.nix {};
      vimPlugins = recurseIntoAttrs (callPackages ./vimPlugins.nix {});
      winbox-bin = callPackages ./winbox {};
      winbox = winbox-bin;
    } // nodeLib.generatePackages {
      nodePackagesPath = ./nodePackages;
    }
)
