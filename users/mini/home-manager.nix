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
      # homebrew paths
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
      export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

      # zsh shell completions
      fpath=(~/.config/zsh $fpath)
      autoload -Uz compinit
      compinit -u

      # miniconda
      eval "$(conda "shell.$(basename $SHELL)" hook)"
      # conda config --add channels conda-forge
      # conda config --set channel_priority strict
      # conda config --set changeps1 False
      # conda create -y -n py313 python=3.13
      conda activate py313

      eval "$(register-python-argcomplete pipx)"

      # fnm - nodejs version manager
      eval "$(fnm env --use-on-cd)"

      # pnpm
      export PNPM_HOME="/Users/mini/Library/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end
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
