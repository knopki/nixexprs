{ callPackage }: {
  commander = callPackage ./commander/2.20.3.nix {};
  commander_2-20-3 = callPackage ./commander/2.20.3.nix {};
  namespaces.yarnpkg.lockfile = callPackage (./. + "/@yarnpkg/lockfile/1.1.0.nix") {};
  namespaces.yarnpkg.lockfile_1-1-0 = callPackage (./. + "/@yarnpkg/lockfile/1.1.0.nix") {};
  semver = callPackage ./semver/5.7.1.nix {};
  semver_5-7-1 = callPackage ./semver/5.7.1.nix {};
  yarn-deduplicate = callPackage ./yarn-deduplicate/1.1.1.nix {};
  yarn-deduplicate_1-1-1 = callPackage ./yarn-deduplicate/1.1.1.nix {};
}
