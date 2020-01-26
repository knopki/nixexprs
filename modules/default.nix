{
  # Add your NixOS modules here
  docker = ./docker.nix;
  nix = ./nix.nix;
  profiles = ./profiles;
  services = import ./services;
  system = ./system.nix;
}
