{ config, pkgs, ... }: {
  # we install nix using a separate installer so we don't want nix-darwin
  # to manage it. This tells nix-darwin to just use whatever is running
  nix.useDaemon = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
    '';

  environment.shells = with pkgs; [ zsh ];

  # Add Rust to system packages
  environment.systemPackages = with pkgs; [
    rust-bin.stable.latest.default
  ];

  system = {
    stateVersion = 5;   
    defaults = {
      dock = {
        orientation = "right";
        tilesize = 32;
      };
    };
  };
}
