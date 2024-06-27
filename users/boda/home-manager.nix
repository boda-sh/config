{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;

in {
  home.stateVersion = "24.05";

  home.packages = [
    pkgs.tree
    pkgs.nerdfonts
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "boda";
    userEmail = "bodazhao@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
