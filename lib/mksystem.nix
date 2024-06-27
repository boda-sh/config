{ nixpkgs, inputs }:

name:
{
  system,
  user,
}:

let
  systemFunc = inputs.darwin.lib.darwinSystem;
  home-manager = inputs.home-manager.darwinModules;
  nix-homebrew = inputs.nix-homebrew.darwinModules;
  homebrew-core = inputs.homebrew-core;
  homebrew-cask = inputs.homebrew-cask;
  homebrew-bundle = inputs.homebrew-bundle;

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/darwin.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

in systemFunc rec {
  inherit system;

  modules = [
    machineConfig
    userOSConfig
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import userHMConfig {
        inputs = inputs;
      };
    }

    nix-homebrew.nix-homebrew
    {
      nix-homebrew = {
        inherit user;
	      enable = true;
        taps = {
          "homebrew/homebrew-core" = homebrew-core;
          "homebrew/homebrew-cask" = homebrew-cask;
          "homebrew/homebrew-bundle" = homebrew-bundle;
        };
        mutableTaps = false;
        autoMigrate = true;
      };
    }

    # expose some extra arguments so our modules can parameterize based on them
    {
      config._module.args = {
        currentSystem = system;
	      currentSystemName = name;
	      currentSystemUser = user;
	      inputs = inputs;
      };
    }
  ];
}
