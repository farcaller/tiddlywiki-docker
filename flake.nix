{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      
      tini = pkgs.tini;
      tiddlywiki = pkgs.nodePackages.tiddlywiki;
    in
    {
      dockerImage = pkgs.dockerTools.buildImage {
        name = "ghcr.io/farcaller/tiddlywiki-docker";
        tag = "latest";
        config = {
          Entrypoint = [ "${tini}/bin/tini" "--" "${tiddlywiki}/bin/tiddlywiki" ];
          Labels."org.opencontainers.image.source" = "https://github.com/farcaller/tiddlywiki-docker";
          WorkingDir = "/tiddlywiki";
        };
      };
      version = tiddlywiki.version;
    }
  );
}
