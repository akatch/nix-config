{
  programs.git = {
    enable = true;
    userName = "Al Bowles";
    userEmail = "bowlesan@proton.me";

    aliases = {
      a = "add";
      co = "checkout";
      d = "diff";
      fp = "push --force-with-lease origin HEAD";
      l = "log --format=oneline";
      p = "pull";
      poh = "push origin HEAD";
      s = "stash";
      st = "status -s";
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
