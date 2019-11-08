{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.knopki.system;
in
{
  options.knopki.system = {
    enable = mkEnableOption "Enable system module";
    nonLocalBinds = (mkEnableOption "Allow bind to non-local IP addresses") // { default = true; };
    rebootOnPanicOrOOM = (mkEnableOption "Panic or OOM leads to reboot") // { default = true; };
    latestKernel = mkEnableOption "Use latest kernel package";
    makeLinuxFastAgain = mkEnableOption
      "Use kernel params from https://make-linux-fast-again.com/";
    optimizeForWorkstation = mkEnableOption "Enable workstation optimizations";
  };

  config = mkIf cfg.enable (
    mkMerge [
      #
      # Allow bind to non-local IP addresses
      #
      (
        mkIf (cfg.nonLocalBinds) {
          boot.kernel.sysctl = {
            "net.ipv4.ip_nonlocal_bind" = 1;
            "net.ipv6.ip_nonlocal_bind" = 1;
          };
        }
      )

      #
      # Reboot on panic or OOM
      #
      (
        mkIf (cfg.rebootOnPanicOrOOM) {
          boot.kernel.sysctl = {
            "kernel.panic_on_oops" = 1;
            "kernel.panic" = 20;
            "vm.panic_on_oom" = 1;
          };
        }
      )

      #
      # Use latest kernel package
      #
      (
        mkIf (cfg.latestKernel) {
          boot.kernelPackages = pkgs.linuxPackages_latest;
        }
      )

      #
      # Make linux fast again
      #
      (
        mkIf (cfg.makeLinuxFastAgain) {
          boot.kernelParams = [
            "noibrs"
            "noibpb"
            "nopti"
            "nospectre_v2"
            "nospectre_v1"
            "l1tf=off"
            "nospec_store_bypass_disable"
            "no_stf_barrier"
            "mds=off"
            "mitigations=off"
          ];
        }
      )

      #
      # Optimize for workstation
      #
      (
        mkIf (cfg.optimizeForWorkstation) {
          knopki.system = {
            latestKernel = true;
            makeLinuxFastAgain = true;
            nonLocalBinds = true;
            rebootOnPanicOrOOM = true;
          };
          boot = {
            kernel.sysctl = { "fs.inotify.max_user_watches" = 524288; };
            kernelParams = [ "quiet" "splash" "nohz_full=1-7" ];
            tmpOnTmpfs = true;
          };
        }
      )
    ]
  );
}
