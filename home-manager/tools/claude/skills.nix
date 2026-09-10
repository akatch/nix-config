
{
  programs.claude-code = {
    skills = {
      nix-run = ''
        ---
        name: nix-run
        description: Run a CLI tool that is not installed by finding it in nixpkgs and invoking it with `nix run`. Use whenever a needed command is missing (command not found), or before suggesting the user install anything with brew, npm -g, pip, cargo install, or go install. Also use when asked to run a one-off tool, try a tool without installing it, or find the nixpkgs attribute for a program.
        ---

        # Run Tools From nixpkgs

        This machine is managed declaratively with nix. Do not install software imperatively.
        When a tool is missing, locate it in nixpkgs and run it with `nix run`.

        ## Task

        1. Check whether the command already exists: `command -v <tool>`. If it does, just use it.
        2. Find the nixpkgs attribute name. The attribute is often, but not always, the
           command name.
           - `nix search nixpkgs <tool>` — searches attribute names and descriptions.
           - If that is ambiguous or empty, search by the binary the package installs at
             <https://search.nixos.org/packages> and confirm the attribute there.
        3. Run it: `nix run nixpkgs#<attr> -- <args>`
           - Everything after `--` is passed to the program, not to nix.
           - With no `--`, nix will try to interpret the flags itself.
        4. If the attribute's default app is not the binary you want, use the package's
           store path instead: `nix shell nixpkgs#<attr> --command <binary> <args>`.
        5. Report the exact command you ran, and note that the tool was run ephemerally
           and is not installed.

        ## Rules

        - Never run `brew install`, `npm install -g`, `pip install`, `cargo install`, or
          `go install`. Those escape the nix configuration.
        - Never edit files under ~/.nix-profile or run `nix profile install` without asking.
        - Prefer `nix run` for one-off invocations. It fetches into the store and leaves no
          imperative state.
        - Prefer `nix shell nixpkgs#<attr> --command ...` when a single invocation needs
          several binaries from the package, or when the package's default app is wrong.
        - Verify the attribute exists before running: an unfree or renamed package will fail
          with a confusing error. `nix search nixpkgs ^<attr>$` confirms an exact match.
        - For unfree packages, add `--impure` with `NIXPKGS_ALLOW_UNFREE=1`, and say so
          explicitly rather than doing it silently.
        - Pin nothing by default. `nixpkgs#<attr>` follows the registry entry; only pin a
          specific revision if the user asks for reproducibility.
        - Do not guess an attribute name. If `nix search` finds nothing, say so and ask,
          rather than inventing a plausible attribute.
        - If the tool will be needed repeatedly, mention that it belongs in
          `home.packages` in this repo, but do not add it without being asked.

        ## Reference

        - `nix run` — <https://nix.dev/manual/nix/stable/command-ref/new-cli/nix3-run>
        - `nix shell` — <https://nix.dev/manual/nix/stable/command-ref/new-cli/nix3-shell>
        - `nix search` — <https://nix.dev/manual/nix/stable/command-ref/new-cli/nix3-search>
        - Package search — <https://search.nixos.org/packages>
        - Ad hoc environments — <https://nix.dev/tutorials/first-steps/ad-hoc-shell-environments.html>
      '';
    };
  };
}
