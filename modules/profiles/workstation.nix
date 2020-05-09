{ config, pkgs, lib, ... }:
with lib; {
  imports = [ ../docker.nix ./essential.nix ];

  options = {
    knopki.profiles.workstation.enable = mkEnableOption "Workstation profile";
  };

  config = mkIf config.knopki.profiles.workstation.enable {
    knopki = {
      docker.enable = mkDefault true;
      nix.gcKeep = mkDefault true;
      profiles.essential.enable = mkDefault true;
      system.optimizeForWorkstation = mkDefault true;
    };

    boot.supportedFilesystems = [ "ntfs" ];

    environment.gnome3.excludePackages = with pkgs.gnome3; [
      epiphany
      geary
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-contacts
      gnome-logs
      gnome-maps
      gnome-music
      gnome-photos
      gnome-screenshot
      gnome-software
      gnome-weather
      totem
      yelp
    ];

    environment.systemPackages = with pkgs; [
      borgbackup
      gnome3.dconf-editor
      pavucontrol
      pinentry_gnome
      powertop
      qt5.qtwayland
      qt5ct
      virtmanager
    ];

    fonts = {
      enableFontDir = true;
      fonts = with pkgs; [
        emojione
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        fira-code-symbols
        font-awesome_4
        noto-fonts
      ];
      fontconfig = {
        defaultFonts = {
          emoji = [ "Noto Color Emoji" "EmojiOne Color" ];
          monospace = [ "Noto Sans Mono" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
        };
        localConf = ''
          <?xml version="1.0" ?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig>
            <!-- there we fix huge icons -->
            <match target="scan">
              <test name="family">
                <string>Noto Color Emoji</string>
              </test>
              <edit name="scalable" mode="assign">
                <bool>false</bool>
              </edit>
            </match>
          </fontconfig>
        '';
      };
    };

    hardware.sane = {
      enable = mkDefault true;
      extraBackends = [];
    };

    hardware.pulseaudio = {
      enable = mkDefault true;
      support32Bit = mkDefault true;
    };

    networking = { networkmanager.enable = true; };

    programs = {
      adb.enable = true;
      dconf.enable = true;
      light.enable = true;
      ssh.startAgent = true;
      sway = {
        enable = true;
        extraPackages = with pkgs; [ swaybg swayidle swaylock xwayland ];
        extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export XDG_SESSION_TYPE=wayland
          # needs qt5.qtwayland in systemPackages
          export QT_QPA_PLATFORM=wayland
          export QT_QPA_PLATFORMTHEME=qt5ct
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          # Fix for some Java AWT applications (e.g. Android Studio),
          # use this if they aren't displayed properly:
          export _JAVA_AWT_WM_NONREPARENTING=1
          export SSH_ASKPASS=${pkgs.gnome3.seahorse}/libexec/seahorse/ssh-askpass
        '';
      };
    };

    services = {
      avahi = {
        enable = true;
        nssmdns = true;
      };
      dbus.packages = with pkgs; [ gnome3.dconf ];
      earlyoom.enable = true;
      flatpak.enable = true;
      fwupd.enable = true;
      gnome3 = {
        core-os-services.enable = true;
        core-shell.enable = true;
        core-utilities.enable = true;
      };
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
      xserver = {
        desktopManager.gnome3.enable = true;
        displayManager.extraSessionFilePackages = [ pkgs.sway ];
      };
    };

    virtualisation.libvirtd.enable = true;
  };
}
