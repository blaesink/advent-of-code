{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    # nixpkgs-python.url = "github:cachix/nixpkgs-python";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = forEachSystem (system: {
        devenv-up = self.devShells.${system}.default.config.procfileScript;
      });

      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            pythonPackages = pkgs.python311Packages;
            pyPkgs = pythonPackages: with pythonPackages; [
              gitpython
              loguru
              pytest
              pytest-watch
              ruff-lsp
              typer
            ];
          in
          {

            default = devenv.lib.mkShell {
              inherit inputs pkgs;

              modules = [
                {
                  languages.python = {
                    enable = true;
                  };

                  packages = with pkgs; [
                    (python3.withPackages pyPkgs)
                    pyright
                    ruff
                  ];

                  scripts = {
                    run.exec = "python3 src/main.py $*";
                    debug.exec = "LOGURU_LEVEL=DEBUG python3 src/main.py $*";
                    pt.exec = "pytest $*";
                  };
                }
              ];
            };
          });
    };
}
