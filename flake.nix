{
  description = "r0bert.dev";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
	    hugo
	    rsync
          ];
          shellHook = ''
            export PS1="\n\[\033[1;32m\][r0bert-dev:\\w]\$\[\033[0m\] "
          '';
        };
      }
    );
}
