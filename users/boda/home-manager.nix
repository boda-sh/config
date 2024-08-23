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

      # pyenv - python version manager
      export PYENV_ROOT="$HOME/.pyenv"
      [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
      eval "$(pyenv init -)"

      # fnm - nodejs version manager
      eval "$(fnm env --use-on-cd)"
    '';
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

  # if not found with home-manager
  home.packages = [
    pkgs.nerdfonts

    pkgs.fnm # for nodejs
    pkgs.pyenv # for python
    pkgs.postgresql_16

    pkgs.croc
    pkgs.gdu
    pkgs.tree
  ];
}
