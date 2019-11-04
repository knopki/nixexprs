{ buildNodePackage, nodePackages, pkgs }:
buildNodePackage {
  name = "commander";
  version = "2.20.3";
  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/commander/-/commander-2.20.3.tgz";
    sha1 = "fd485e84c03eb4881c20722ba48035e8531aeb33";
  };
  deps = [];
  meta = {
    homepage = "https://github.com/tj/commander.js#readme";
    description = "the complete solution for node.js command-line programs";
    keywords = [
      "commander"
      "command"
      "option"
      "parser"
    ];
  };
}
