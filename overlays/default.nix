{
  # Add your overlays here
  fishPlugins = import ./fishPlugins.nix;
  lsColors = import ./lsColors.nix;
  morph = import ./morph.nix;
  neovim-gtk = import ./neovim-gtk.nix;
  niv = import ./niv.nix;
  nixfromnpm = import ./nixfromnpm.nix;
  nixpkgs-fmt = import ./nixpkgs-fmt.nix;
  nix-direnv = import ./nix-direnv.nix;
  pulumi = import ./pulumi.nix;
  telepresence = import ./telepresence.nix;
  vimPlugins = import ./vimPlugins.nix;
  waybar = import ./waybar.nix;
  winbox = import ./winbox.nix;
}
