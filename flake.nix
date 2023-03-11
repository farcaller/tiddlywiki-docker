{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      tiddlywiki = pkgs.nodePackages.tiddlywiki;
    in
    {
      dockerImage = pkgs.dockerTools.buildImage {
        name = "ghcr.io/farcaller/tiddlywiki-docker";
        tag = "latest";

        config = {
          Entrypoint = [ "${tiddlywiki}/bin/tiddlywiki" ];
          WorkingDir = "/tiddlywiki";
        };
      };
      version = tiddlywiki.version;
    }
  );
}
