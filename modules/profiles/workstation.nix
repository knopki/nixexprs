{ config, pkgs, lib, ... }:
with lib;
{
  imports = [ ./essential.nix ];

  options = { knopki.profiles.workstation.enable = mkEnableOption "Workstation profile"; };

  config = mkIf config.knopki.profiles.workstation.enable {
    knopki = {
      nix.gcKeep = true;
      profiles.essential.enable = true;
      system.optimizeForWorkstation = true;
    };

    environment.systemPackages = with pkgs; [
      borgbackup
      powertop
    ];

    hardware.sane = {
      enable = true;
      extraBackends = [];
    };

    networking = {
      networkmanager.enable = true;
    };

    programs = {
      adb.enable = true;
      ssh.startAgent = true;
    };

    services = {
      avahi = {
        enable = true;
        nssmdns = true;
      };
      earlyoom.enable = true;
      flatpak.enable = true;
      fwupd.enable = true;
      locate = {
        enable = true;
        localuser = null;
        locate = pkgs.mlocate;
        pruneBindMounts = true;
      };
      kbfs.enable = true;
      keybase.enable = true;
      printing = {
        enable = true;
        drivers = with pkgs; [ cups-kyocera gutenprint ];
      };
      trezord.enable = true;
    };
  };
}
