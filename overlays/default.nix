let
  all = {
    # Add your overlays here
    fishPlugins = import ./fishPlugins.nix;
    lsColors = import ./lsColors.nix;
    neovim-gtk = import ./neovim-gtk.nix;
    nixfromnpm = import ./nixfromnpm.nix;
    nix-direnv = import ./nix-direnv.nix;
    nodePackages = import ./nodePackages.nix;
    pulumi = import ./pulumi.nix;
    telepresence = import ./telepresence.nix;
    vimPlugins = import ./vimPlugins.nix;
    waybar = import ./waybar.nix;
    winbox = import ./winbox.nix;
  };
in
all // {
  # Create all-in-one overlay for lazy ones like me
  allOverlays = self: super: with super.lib; (
    foldr recursiveUpdate {} (map (x: x self super) (attrValues all))
  );
}
