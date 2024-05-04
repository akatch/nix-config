# Nix Configuration

hacker shit

inspired by [the-nix-way/nome][], [anthr76/snowflake][], and [coreweave/coreweave.nix][].

## Tips 'n' Tricks

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
[coreweave.nix manual]: https://effective-guide-8p4wm51.pages.github.io/home.html
[coreweave.nix]: https://github.com/coreweave/coreweave.nix
[nixOS modules]: https://nixos.wiki/wiki/NixOS_modules
