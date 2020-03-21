{ pkgs ? import <nixpkgs> {}, lib, newScope, recurseIntoAttrs, sources ? import ../nix/sources.nix, nodejs ? pkgs.nodejs }:
lib.makeScope newScope (
  self: with self; let
    callPackage = lib.callPackageWith (pkgs // self // { inherit sources; });
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
      lsColors = callPackage ./ls-colors.nix {};
      neovim-gtk = callPackage ./neovim-gtk {};
      nixfromnpm = callPackage ./nixfromnpm {};
      kube-score = callPackage ./kube-score {};
      kustomize1 = callPackage ./kustomize1 {};
      nix-direnv = callPackage ./nix-direnv.nix {};
      vimPlugins = recurseIntoAttrs (callPackages ./vimPlugins.nix {});
      winbox-bin = callPackage ./winbox {};
      winbox = winbox-bin;
    } // nodeLib.generatePackages {
      nodePackagesPath = ./nodePackages;
    }
)
