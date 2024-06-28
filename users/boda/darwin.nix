{ inputs, pkgs, ... }:

{
  # the user should already exist, but we need to set this so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423)
  users.users.boda = {
    home = "/Users/boda";
  };

  homebrew = {
    # this is a module from nix-darwin, but homebrew is installed via nix-homebrew
    enable = true;

    # use brew for the lastest versions of a package
    brews = [
    ];

    casks = [
      "1password"
      "firefox"
      "google-chrome"
      "mullvadvpn"
      "notion"
      "raycast"
      "syncthing"
      "timing"
      "visual-studio-code"
    ];
  };
}
