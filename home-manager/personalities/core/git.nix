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
    userName = "Al Bowles";
    userEmail = "bowlesan@proton.me";

    aliases = {
      a = "add";
      b = "branch";
      c = "commit";
      co = "checkout";
      d = "diff";
      dc = "diff --cached";
      fp = "push --force-with-lease origin HEAD";
      l = "log --format=oneline -n 10 --abbrev-commit";
      p = "pull";
      poh = "push origin HEAD";
      pdh = "push downstream HEAD";
      s = "stash";
      st = "status -s";
      sw = "switch";
    };

    signing = {
      key = "D2E81FDAB5928BBC";
    };

    extraConfig = {
      branch.sort = "-committerdate";
      column.ui = "auto";
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
  };
}
