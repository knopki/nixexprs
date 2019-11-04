self: super: {
  nixfromnpm = (super.callPackage ../pkgs {}).nixfromnpm;
}
