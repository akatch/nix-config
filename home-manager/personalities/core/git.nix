{
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      aliases = {
        app = "pr review --approve";
        co = "pr checkout";
        d = "pr diff";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Al Bowles";
        email = "bowlesan@proton.me";
      };

      alias = {
        a = "add";
        b = "branch";
        c = "commit";
        co = "checkout";
        cp = "cherry-pick";
        d = "diff";
        dc = "diff --cached";
        fp = "push --force-with-lease origin HEAD";
        l = "log --format=oneline -n 10 --abbrev-commit";
        p = "pull";
        poh = "push origin HEAD";
        pdh = "push downstream HEAD";
        rpo = "remote prune origin";
        s = "stash";
        st = "status -s";
        sw = "switch";
        wt = "worktree";
        wta = "!f() { root=$(dirname $(git rev-parse --path-format=absolute --git-common-dir)) && branch=ab/\"$1\" && if git show-ref --verify --quiet \"refs/heads/$branch\"; then git worktree add \"$root/wt/$1\" \"$branch\"; else git worktree add -b \"$branch\" \"$root/wt/$1\"; fi; }; f";
      };

      branch.sort = "-committerdate";
      commit.verbose = true;
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      init.defaultBranch = "main";
      pull = {
        rebase = true;
        autoStash = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      tag.sort = "version:refname";
    };

    signing = {
      key = "D2E81FDAB5928BBC";
      format = null;
    };
  };
}
