self: super: {
  nix-direnv = (super.callPackage ../pkgs {}).nix-direnv;
}
