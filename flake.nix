{
  description = "A simple MoonBit library template";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    moonbit-overlay = {
      url = "github:totto2727/moonbit-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, moonbit-overlay, opencode, ... }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
      mkPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          moonbit-overlay.overlays.default
          opencode.overlays.default
        ];
      };
    in
    {
      devShells = forEachSystem (system:
        let
          pkgs = mkPkgs system;
        in
        rec {
          default = pkgs.mkShell {
            packages = [
              pkgs.moonbit-bin.moonbit.latest
              # Uncomment when preferred_target = "js" in moon.mod.
              # pkgs.nodejs
            ];
          };
          ci = pkgs.mkShell {
            inputsFrom = [ default ];
            packages = [ pkgs.opencode ];
          };
        });
    };
}
