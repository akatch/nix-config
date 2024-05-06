# Nix Configuration

hacker shit

inspired by [the-nix-way/nome][], [anthr76/snowflake][], and [Misterio77/nix-starter-configs][].

## Setup

### NixOS

Stub out a template flake
```shell
nix flake init -t github:misterio77/nix-starter-config#minimal
```

Edit some stuff in flake.nix etc, then

```shell
sudo nixos-rebuild switch --flake .#$(hostname)
home-manager switch --flake .#$(whoami)@$(hostname)
```

## Tips 'n' Tricks

### Add unstable channel

```shell
nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
nix-channel --update
```

### Upgrading packages

```shell
nix flake update
home-manager switch --flake .#$(whoami)@$(hostname)
```

### Run arbitrary packages in a sandboxed `nix-shell`

```shell
nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
nix-channel --update
nix-shell -p alacritty
```

### Slick dev envs

Check out [nix + direnv][]

[the-nix-way/nome]: https://github.com/the-nix-way/nome
[anthr76/snowflake]: https://github.com/anthr76/snowflake
[coreweave/coreweave.nix]: https://github.com/coreweave/coreweave.nix
[nix + direnv]: https://determinate.systems/posts/nix-direnv/
[home-manager manual]: https://nix-community.github.io/home-manager/options.xhtml
[nixOS modules]: https://nixos.wiki/wiki/NixOS_modules
[Misterio77/nix-starter-configs]: https://github.com/Misterio77/nix-starter-configs?search=1
