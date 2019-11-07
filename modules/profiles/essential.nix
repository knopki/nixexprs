{ config, pkgs, lib, ... }:
with lib;
{
  options = { knopki.profiles.essential.enable = mkEnableOption "Essential profile"; };

  config = mkIf config.knopki.profiles.essential.enable {
    boot.kernel.sysctl = {
      "kernel.panic_on_oops" = 1;
      "kernel.panic" = 20;
      "net.ipv4.ip_nonlocal_bind" = 1;
      "net.ipv6.ip_nonlocal_bind" = 1;
      "vm.panic_on_oom" = 1;
    };

    # common packages on all machines (very opionated)
    # merged with `requiredPackages' from
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/system-path.nix
    environment.systemPackages = with pkgs; [
      bat
      bind
      binutils
      cachix
      file
      gitAndTools.gitFull
      gnupg
      htop
      jq
      lm_sensors
      lsof
      neovim
      pciutils
      pinentry
      pinentry_ncurses
      pstree
      python3 # required by ansible (remove?)
      ranger
      ripgrep
      sysstat
      tree
      unrar
      unzip
      usbutils
      wget
    ];

    hardware.enableRedistributableFirmware = mkDefault true;

    i18n = {
      consoleFont = mkDefault "latarcyrheb-sun16";
      consoleKeyMap = mkDefault "us";
      defaultLocale = mkDefault "en_US.UTF-8";
      supportedLocales = mkDefault [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
    };

    knopki.nix = {
      enable = mkDefault true;
      nixPathFreeze = true;
    };

    programs = {
      command-not-found.enable = mkDefault false;
      fish.enable = mkDefault true;
      iftop.enable = mkDefault true;
      iotop.enable = mkDefault true;
      mosh.enable = mkDefault true;
      mtr.enable = mkDefault true;
      tmux.enable = mkDefault true;
    };

    security = {
      polkit.extraConfig = ''
        /* Allow users in wheel group to manage systemd units without authentication */
        polkit.addRule(function(action, subject) {
            if (action.id == "org.freedesktop.systemd1.manage-units" &&
                subject.isInGroup("wheel")) {
                return polkit.Result.YES;
            }
        });
      '';

      sudo.extraConfig = ''
        Defaults timestamp_type=global,timestamp_timeout=600
      '';

      sudo.extraRules = [
        {
          commands = [
            {
              command = "/run/current-system/sw/bin/nixos-rebuild switch";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];
    };

    services = {
      dbus.socketActivated = mkDefault true;

      openssh = {
        enable = mkDefault true;
        passwordAuthentication = mkDefault false;
        startWhenNeeded = mkDefault true;
      };

      timesyncd.servers = mkDefault [ "time.cloudflare.com" ];
    };
  };
}
