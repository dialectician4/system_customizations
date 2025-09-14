{ config, pkgs, ... }:

let
  user = "edwinsantos"; # Not necessary but added just so keep this well-formed
  # in absence of emacsOverlay variable
  # emacsOverlaySha256 = "1ahb00nna1kj2y07b2p8baxraf4lpfnbj2wlj3bz655ia223q51m";
in
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    overlays =
      # Apply each overlay found in the /overlays directory
      let path = ../../overlays; in with builtins;
      map (n: import (path + ("/" + n)))
          (filter (n: match ".*\\.nix" n != null ||
                      pathExists (path + ("/" + n + "/default.nix")))
                  (attrNames (readDir path)));

      # ++ [(import (builtins.fetchTarball {
      #          url = "https://github.com/nix-community/emacs-overlay/archive/refs/heads/master.tar.gz";
      #          sha256 = emacsOverlaySha256;
      #      }))]
  };
}
