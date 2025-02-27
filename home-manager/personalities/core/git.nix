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
      pull = {
        rebase = true;
        autoStash = true;
      };
      commit.verbose = true;
    };
  };
}
