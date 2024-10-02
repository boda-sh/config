# My dotfiles (managed by nix on macOS)

I store my dotfiles in the `~/.config` directory, and manage them with `nix` on macOS.

## Prerequisites

> Tested on macOS Sequoia 15, nix-installer v0.27 and nix v2.24.9

Run `xcode-select --install` on a fresh macOS install.

Install `nix` with the `nix-installer`: https://github.com/DeterminateSystems/nix-installer

Clone this repo to `~/.config`

## Get Started

- ⚠️ Look through codebase to change relevant user detail (pc name, username, email, etc.)!
- Run `make` from the root directory to install all packages and setup the system

## Daily Operations

- Make changes (add apps, edit configs, etc.)
- (Optional) Run `nix flake update`
- Run `make` from the root directory

## What's Included?

- `alacritty`
- `homebrew` with bundle and cask
- `neovim` with `astronvim`
- `nix-darwin`, `home-manager`
- `nodejs` with `fnm`, then `npm i -g bun/pnpm/yarn/etc...`
- `python` with `pyenv`
- `rust`
- `zellij`
- `zsh` with `starship`
- etc...

## Useful Links

- `nix` documentation: https://nix.dev/manual/nix/
- Search `nix` packages: https://search.nixos.org/packages
- `nix-darwin` documentation: https://daiderd.com/nix-darwin/manual/index.html
- `home-manager` documentation: https://nix-community.github.io/home-manager/
- `home-manager` option search: https://home-manager-options.extranix.com

## FAQs

You may have to run `git add .` in repo root first for changes to be picked up.

### Doesn't `homebrew`, `nix-darwin`, and `home-manager` conflict?

Most times, I follow this order:

1. see if `home-manager` programs supports it
2. install through `home-manager` packages
3. use `homebrew` (brew is useful for complex GUI apps like Firefox)

### Existing `/etc/nix/nix.conf` file

The nix-installer will write a `/etc/nix/nix.conf` file first, and `nix-darwin` might complain.

In that case, run `sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin`

### What about secrets and SSH?

I use 1password to manage SSH and secrets, see https://developer.1password.com/docs/ssh/

### How to upgrade `nix`?

Run `sudo -i nix upgrade-nix`

### How to clean up `nix`?

Run `nix-collect-garbage -d`

## Inspirations

- https://github.com/mitchellh/nixos-config
- https://github.com/dustinlyons/nixos-config
