# My dotfiles (managed by nix with macOS)

I store my dotfiles in the `~/.config` directory, and manage them with `nix` on macOS.

## Prerequisites

Run `xcode-select --install` on a fresh macOS install.

Install `nix` with the `nix-installer`: https://github.com/DeterminateSystems/nix-installer

Look through codebase to change relevant user credentials (username, email, etc.)

Run `make`

## What's Included?

- `zsh` with `starship`
- `nix-darwin`, `home-manager`
- `homebrew` with bundle and cask
- `alacritty`

## Useful Links

- `nix` documentation: https://nix.dev/manual/nix/2.22/
- Search `nix` packages: https://search.nixos.org/packages
- `nix-darwin` documentation: https://daiderd.com/nix-darwin/manual/index.html
- `home-manager` documentation: https://nix-community.github.io/home-manager/
- `home-manager` option search: https://home-manager-options.extranix.com

## FAQs

### git tracking

We may have to run `git add .` in repo root first for changes to be picked up.

### Doesn't `homebrew`, `nix-darwin`, and `home-manager` conflict?

Most times, if I want to install something, I follow this order:

1. see if `home-manager` programs supports it
2. use `homebrew` through `nix-darwin` (always use brew for complex GUI apps like Firefox)

### Existing `/etc/nix/nix.conf` file

The nix-installer will write a `/etc/nix/nix.conf` file first, and `nix-darwin` might complain.

In that case, run `sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin`

### What about secrets and SSH?

I use 1password to manage SSH and secrets, see https://developer.1password.com/docs/ssh/

### How to upgrade `nix`?

Run `sudo -i nix upgrade-nix`

### How to clean up `nix`?

Run `nix-collect-garbage -d`
