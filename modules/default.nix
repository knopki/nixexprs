{
  # Add your NixOS modules here
  docker = ./docker.nix;
  nix = ./nix.nix;
  profiles = ./profiles;
  system = ./system.nix;
}
