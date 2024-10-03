{ inputs, ... }:

{ config, lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;

in {
  home.stateVersion = "24.05";

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  # manage the zshrc file content for us
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ".." = "cd ..";
      "ga" = "git add .";
      "gf" = "git fetch && git pull";
      "gm" = "git switch main";
      "gp" = "git push";
      "gs" = "git status";
    };
    initExtra = ''
      # homebrew
      export PATH="/opt/homebrew/bin:$PATH"

      # miniconda
      eval "$(conda "shell.$(basename $SHELL)" hook)"
      # conda config --add channels conda-forge
      # conda config --set channel_priority strict
      conda create -y -n py312 python=3.12
      conda activate py312

      # fnm - nodejs version manager
      eval "$(fnm env --use-on-cd)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      gcloud.disabled = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "boda";
    userEmail = "bodazhao@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBSsZx4gVoRPwCWgRPNqwCk684zyO9X4TtL9SG9RAgHH";
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 13;
        normal = {
          family = "Hack Nerd Font";
        };
      };
    };
  };

  # editors
  programs.vim.enable = true;
  programs.neovim.enable = true;
  programs.zellij.enable = true;

  # util CLIs
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.jq.enable = true;
  programs.lazygit.enable = true;
  programs.lsd.enable = true;
  programs.ripgrep.enable = true;

  # if not found with home-manager programs, search nix packages
  home.packages = [
    pkgs.nerdfonts

    pkgs.fnm # for nodejs
    pkgs.postgresql_16

    pkgs.croc
    pkgs.gdu
    pkgs.tree
  ];
}
