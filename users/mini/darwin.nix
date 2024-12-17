{ inputs, pkgs, ... }:

{
  # the user should already exist, but we need to set this so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423)
  users.users.mini = {
    home = "/Users/mini";
  };

  homebrew = {
    # this is a module from nix-darwin, but homebrew is installed via nix-homebrew
    enable = true;

    # use brew for the lastest versions of a package
    brews = [
      "azure-cli"
      "datasette"
      "deno"
      "flyctl"
      "pnpm"
      "ruby"
      "sqlite"
    ];

    # casks are usually GUI apps
    casks = [
      "1password"
      "arc"
      "firefox"
      "flux"
      "google-chrome"
      "miniconda"
      "raycast"
      "slack"
      "syncthing"
      "timing"
      "visual-studio-code"
      "vlc"
    ];
  };
}
