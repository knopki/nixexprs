{ config, lib, ... }:

with lib; {
  options.knopki.docker.enable = mkEnableOption "Enable Docker";

  config = mkIf config.knopki.docker.enable {
    virtualisation.docker = {
      autoPrune.dates = mkDefault "weekly";
      autoPrune.enable = mkDefault true;
      enable = mkDefault true;
      enableOnBoot = mkDefault true;
      liveRestore = mkDefault true;
    };
  };
}
