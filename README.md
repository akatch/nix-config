# Nix Configuration

hacker shit

inspired by [the-nix-way/nome][], [anthr76/snowflake][], and [Misterio77/nix-starter-configs][].

## Setup

### NixOS

Start a nix-shell with some basic tools

```shell
export NIX_CONFIG="experimental-features = nix-command flakes"
nix shell nixpkgs#git nixpkgs#home-manager
```

Stub out a template flake
```shell
nix flake init -t github:misterio77/nix-starter-config#minimal
```

Edit some stuff in flake.nix etc, then

```shell
home-manager switch --flake .#$(whoami)@$(hostname)
sudo nixos-rebuild switch --flake .#$(hostname)
```

## Tips 'n' Tricks

### System upgrades

Update `inputs.nixpkgs.url`, then

```shell
nix flake update
home-manager switch --flake .#$(whoami)@$(hostname)
sudo nixos-rebuild boot --flake .#$(hostname)
```
Then reboot

### Upgrading packages

```shell
sudo nixos-rebuild switch --upgrade --flake .#$(hostname)
```

### Run arbitrary packages in a sandboxed `nix-shell`

```shell
nix-shell -p alacritty
```

### Slick dev envs

Check out [nix + direnv][]

### Package search

Search for specific [versions][nix package versions] of packages and get installation directions

### Dev templates

Get started with some basic [flake dev templates][] for every language

[the-nix-way/nome]: https://github.com/the-nix-way/nome
[anthr76/snowflake]: https://github.com/anthr76/snowflake
[coreweave/coreweave.nix]: https://github.com/coreweave/coreweave.nix
[nix + direnv]: https://determinate.systems/posts/nix-direnv/
[home-manager manual]: https://nix-community.github.io/home-manager/options.xhtml
[nixOS modules]: https://nixos.wiki/wiki/NixOS_modules
[Misterio77/nix-starter-configs]: https://github.com/Misterio77/nix-starter-configs
[nix package versions]: https://lazamar.co.uk/nix-versions/
[flake dev templates]: https://github.com/the-nix-way/dev-templates/tree/main
