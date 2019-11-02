with rec {
  sources = import ../nix/sources.nix;
  src = sources.telepresence;
  sshuttleSrc = sources.telepresence-sshuttle;
};
self: super: {
  telepresence = super.telepresence.overrideAttrs (
    o: rec {
      inherit src;
      inherit (src) version;
      postInstall = ''
        wrapProgram $out/bin/telepresence \
          --prefix PATH : ${super.lib.makeBinPath [
        super.sshfs-fuse
        super.torsocks
        super.conntrack-tools
        super.openssh
        super.coreutils
        super.iptables
        super.bash
        (
          super.lib.overrideDerivation super.sshuttle (
            p: {
              src = super.fetchgit {
                inherit (sshuttleSrc) url rev sha256;
              };
              nativeBuildInputs = p.nativeBuildInputs ++ [ super.git ];
              postPatch = "rm sshuttle/tests/client/test_methods_nat.py";
              postInstall = "mv $out/bin/sshuttle $out/bin/sshuttle-telepresence";
            }
          )
        )
      ]}
      '';
    }
  );
}
