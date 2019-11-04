self: super: {
  nodePackages = (super.callPackage ../pkgs {}).nodePackages;
}
