{ buildNodePackage, namespaces, nodePackages, pkgs }:
buildNodePackage {
  name = "yarn-deduplicate";
  version = "1.1.1";
  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/yarn-deduplicate/-/yarn-deduplicate-1.1.1.tgz";
    sha1 = "19b4a87654b66f55bf3a4bd6b153b4e4ab1b6e6d";
  };
  deps = with nodePackages; [
    commander_2-20-3
    namespaces.yarnpkg.lockfile_1-1-0
    semver_5-7-1
  ];
  meta = {
    homepage = "https://github.com/atlassian/yarn-deduplicate#readme";
    description = "Deduplication tool for yarn.lock files";
    keywords = [
      "yarn"
      "yarn.lock"
      "lockfile"
      "duplicated"
      "package manager"
      "dedupe"
      "deduplicate"
    ];
  };
}
