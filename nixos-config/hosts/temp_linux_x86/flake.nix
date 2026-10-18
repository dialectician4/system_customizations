{
  description = "Temporary config for non-NixOS Linux systems.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # change to aarch64-linux / aarch64-darwin / x86_64-darwin as needed
      pkgs = import nixpkgs {
inherit system;
config.allowUnfree = true;
};
      # Import the shared package list. The path is relative to this flake.nix.
      sharedPackages = import ../../modules/shared/packages.nix { inherit pkgs; };
    in {
      packages.${system}.default = pkgs.buildEnv {
        name = "temp-core-tools";
        paths = sharedPackages ++ [
 pkgs.wezterm
 pkgs.neovim 
 pkgs.starship
 pkgs.zoxide
];
      };
    };
}
