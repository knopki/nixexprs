{ pkgs, lib, newScope, recurseIntoAttrs, sources }:
lib.makeScope newScope (
  self: with self; let
    callPackages = lib.callPackagesWith (pkgs // self // { inherit sources; });
  in
    rec {
      fishPlugins = recurseIntoAttrs (callPackages ./fish-plugins {});
      lsColors = callPackages ./ls-colors.nix {};
      neovim-gtk = callPackages ./neovim-gtk {};
      kube-score = callPackages ./kube-score {};
      kustomize1 = callPackages ./kustomize1 {};
      nix-direnv = callPackages ./nix-direnv.nix {};
      vimPlugins = recurseIntoAttrs (callPackages ./vimPlugins.nix {});
      winbox-bin = callPackages ./winbox {};
      winbox = winbox-bin;
    }
)
