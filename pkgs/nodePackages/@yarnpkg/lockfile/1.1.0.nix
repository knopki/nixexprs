{ buildNodePackage, fetchUrlNamespaced, namespaceTokens, nodePackages, pkgs }:
buildNodePackage {
  name = "lockfile";
  version = "1.1.0";
  src = fetchUrlNamespaced {
    url = "https://registry.npmjs.org/@yarnpkg/lockfile/-/lockfile-1.1.0.tgz";
    sha1 = "e77a97fbd345b76d83245edcd17d393b1b41fb31";
    namespace = "yarnpkg";
  };
  namespace = "yarnpkg";
  deps = [];
  devDependencies = [];
  meta = {
    description = "The parser/stringifier for Yarn lockfiles.";
    keywords = [
      "yarn"
      "yarnpkg"
      "lockfile"
      "dependency"
      "npm"
    ];
  };
}
