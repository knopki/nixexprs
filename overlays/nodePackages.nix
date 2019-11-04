self: super: {
  nodePackages = super.nodePackages // (super.callPackage ../pkgs {}).nodePackages;
}
