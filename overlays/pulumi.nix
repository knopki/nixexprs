with rec {
  sources = import ../nix/sources.nix;
};
self: super: {
  pulumi-bin = super.pulumi-bin.overrideAttrs (
    o: rec {
      src = sources."pulumi-${super.stdenv.hostPlatform.system}";
      version = src.version;
    }
  );
  pulumi-resource-gcp-bin = super.pulumi-bin.overrideAttrs (
    o: rec {
      pname = "pulumi-resource-gcp-bin";
      src = sources."pulumi-resource-gcp-${super.stdenv.hostPlatform.system}";
      version = src.version;
      setSourceRoot = "sourceRoot=`pwd`";
    }
  );
  pulumi-resource-kubernetes-bin = super.pulumi-bin.overrideAttrs (
    o: rec {
      pname = "pulumi-resource-kubernetes-bin";
      src = sources."pulumi-resource-kubernetes-${super.stdenv.hostPlatform.system}";
      version = src.version;
      setSourceRoot = "sourceRoot=`pwd`";
    }
  );
  pulumi-resource-mysql-bin = super.pulumi-bin.overrideAttrs (
    o: rec {
      pname = "pulumi-resource-mysql-bin";
      src = sources."pulumi-resource-mysql-${super.stdenv.hostPlatform.system}";
      version = src.version;
      setSourceRoot = "sourceRoot=`pwd`";
    }
  );
  pulumi-resource-random-bin = super.pulumi-bin.overrideAttrs (
    o: rec {
      pname = "pulumi-resource-random-bin";
      src = sources."pulumi-resource-random-${super.stdenv.hostPlatform.system}";
      version = src.version;
      setSourceRoot = "sourceRoot=`pwd`";
    }
  );
}
