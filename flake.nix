{
  inputs = {
    self.submodules = true;
    nix-eda.url = "github:fossi-foundation/nix-eda";
  };

  outputs = {
    self,
    nix-eda,
    ...
  }: let
    nixpkgs = nix-eda.inputs.nixpkgs;
    lib = nixpkgs.lib;
  in {
    overlays = {
      default = lib.composeManyExtensions [
        (
          nix-eda.composePythonOverlay (pkgs': pkgs: pypkgs': pypkgs: let
            callPythonPackage = lib.callPackageWith (pkgs' // pypkgs');
          in {
            libparse = callPythonPackage ./default.nix {
              src = self;
            };
          })
        )
      ];
    };

    legacyPackages = nix-eda.forAllSystems (
      system:
        import nix-eda.inputs.nixpkgs {
          inherit system;
          overlays = [nix-eda.overlays.default self.overlays.default];
        }
    );

    packages = nix-eda.forAllSystems (
      system: let
        pkgs = self.legacyPackages."${system}";
      in {
        inherit (pkgs.python3.pkgs) libparse;
        default = self.packages."${system}".libparse;
      }
    );
  };
}
