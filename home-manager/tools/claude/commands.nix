{
  programs.claude-code = {
    commands = {
      save-note = ''
        ---
        description: Save the previous response as a Zettelkasten note
        ---

        ## Task

        Save the previous response using Zettelkasten conventions

        ## Rules

        - Save notes in ~/Documents/Notes
        - Use a timestamp based filename with the pattern YYYYMMDDHHmmss.md
        - Include the prompt in the note
        - The body of the note must contain the exact text of the response
        - Use YAML front matter
        - Always include title, date, and appropriate tags in the front matter
        - Date frontmatter must use the format YYYY-MM-DD HH:mm
        - Always include the 'claude' tag
        - When linking to other notes, use the note title as the link text (eg [My Cool Note](20260430125026.md), not [[20260430125026]])
      '';

      commit-msg = ''
        ---
        description: Propose a meaningful conventional commits style commit message
        ---

        ## Task

        Based on the currently staged changes, generate a concise commit message using conventional commits style.

        ## Rules

        - Do not include yourself as the author in commit messages
        - Don't mention code by, authored by or anything by Claude Code, AI Agent etc.
        - Don't include me as coauthor
        - Follow the pattern of existing commits
        - Use simple language
        - Include only major and meaningful changes
        - Don't need to be exhaustive and capture every last detail
        - Avoid enumerating meaningless metrics like lines of code, number of tests etc
        - For single commit PRs, its sufficient to create the PR with `gh pr create --fill` reusing the commit's message
        - Avoid using emojis and check marks etc in messages
      '';

      recall-setup = ''
        ---
        description: Load project setup context from CLAUDE.md with worktree+beads pattern guide
        ---

        # Project Setup Recall

        Load the project-specific setup from CLAUDE.md file and the general worktree+beads workflow pattern.

        **Project:** $1

        ---

        ## General Workflow Pattern: Git Worktrees + Beads

        This is the standardized pattern you follow for organizing projects:

        ### Directory Structure Pattern

        ```
        ~/code/github.com/organization/projectname/ # Main repository (NEVER EDIT)
          ├── .git/                                 # Git metadata
          ├── .gitignore                            # Must contain "wt/" entry
          ├── [project files...]                    # Always on main branch
          └── wt/                                   # GITIGNORED worktree container
              ├── .beads/                           # Shared beads database (all worktrees)
              ├── CLAUDE.md                         # Project-specific setup info
              ├── feature-branch-1/                 # Worktree for feature-branch-1
              ├── feature-branch-2/                 # Worktree for feature-branch-2
              └── dev/                              # General development worktree
        ```

        ### Core Principles

        1. **Main Repository is Read-Only** - Always tracks `main` branch, never edit directly
        2. **All Work Happens in Worktrees** - Each worktree under `wt/` has its own branch
        3. **Shared Beads Database** - Lives at `~/code/github.com/organization/projectname/wt/.beads/`, shared across all worktrees
        4. **Worktrees are Gitignored** - The `wt/` directory must be in `.gitignore`

        ### Key Commands

        **Worktree Management:**
        ```bash
        git worktree list                    # List all worktrees
        git worktree add wt/name -b branch   # Create new worktree + branch
        git worktree remove wt/name          # Remove worktree
        ```

        **Beads Management (always set context first!):**
        ```bash
        mcp__plugin_beads_beads__set_context("/path/to/project/wt")
        bd list                              # List all issues
        bd show issue-id                     # Show issue details
        bd ready                             # Show ready-to-work issues
        ```

        ### Important Rules

        **DO:**
        - ✅ Always create worktrees under `wt/` directory
        - ✅ Always set beads context to `projectroot/wt` before beads operations
        - ✅ Keep main repository on main branch, never edit
        - ✅ Use worktrees for ALL development work

        **DON'T:**
        - ❌ Never edit files in main repository
        - ❌ Never initialize beads at project root (only in `wt/`)
        - ❌ Never commit `wt/` directory to git
        - ❌ Never forget to set beads context before beads operations

        ---

        ## Project-Specific Setup

        Now load the project-specific CLAUDE.md file:

        Read the file at `~/code/github.com/organization/$1/wt/CLAUDE.md` to get:
        - Beads root location
        - Current worktree structure
        - Branch stacking order
        - Recent work completed
        - Next tasks
        - Active issues
        - Important commands specific to this project

        After reading CLAUDE.md, set the beads context and verify the working directory.
      '';

      sync-loki-freight = ''
        ---
        description: Sync latest Kargo freight to loki observability stages
        ---

        # Sync Loki Freight

        Synchronize the latest freight from the observability project to loki, loki-eu-south, and loki-us-east-usw stages.

        ## Task

        1. Run `kargo login` first to authenticate
        2. Get the latest freight for each stage separately using `infractl kargo list-freight <app-name> --project=observability --all`
           - Each loki stage has its own freight hash (they track the same commits but have different hashes)
           - Query each app: loki, loki-eu-south, loki-us-east-usw
        3. Display the latest freight information for all three stages:
           - Show the freight hash for each stage
           - Show the git commit (should be the same across all stages)
           - Show the commit message
        4. Ask for confirmation before proceeding
        5. If confirmed, promote the freight to all three stages in parallel using background tasks

        ## Rules

        - Always login to kargo first with `kargo login`
        - Use `infractl kargo list-freight <app-name> --project=observability --all` to list freight for each app
        - Each stage has a unique freight hash even when tracking the same git commit
        - The correct command is `infractl kargo promote <app> --project=observability --freight=<hash>` (NOT --stage)
        - The promote command requires interactive confirmation, so pipe `yes |` to auto-confirm
        - Run all three promotions in parallel using background tasks for efficiency
        - Use `yes | infractl kargo promote <app> --project=observability --freight=<hash>` for each stage
        - Wait for all promotions to complete and report success/failure for each
        - Each promotion will show which specific stage was promoted (e.g., loki-us-west-09a-core-observability)
      '';

      pr-review = ''
        ---
        description: Address pull request review comments
        ---

        # PR Review Response

        ## Task

        Address comments on the provided GitHub pull request

        ## Rules

        - Read each comment and list them before changing code
        - Make ONLY the minimal change requested in each comment
        - Do NOT make unrelated improvements or add options not requested
        - Do NOT post replies to GitHub - output suggested replies as text for the user to post
        - After changes, run all tests, linters, and pre-commit hooks
        - Show a summary of files changed and ask before committing
        '';

      new-worktree = ''
        ---
        description: Create a git worktree + ab/ branch for a task, following the wt/ convention
        ---

        # New Worktree For Task

        Create a new worktree and branch for a task named: **$1**

        ## Rules

        - Derive names from the task name `$1`:
          - Worktree dir: `wt/$1` (relative to the repo root; NO `ab/` prefix)
          - Branch: `ab/$1` (WITH the `ab/` prefix)
        - Determine the repo root with `git rev-parse --show-toplevel` and build an
          absolute worktree path. Never `cd`; use `git -C <repo-root>` for all git calls.
        - Base the branch on the up-to-date default branch:
          - `git -C <repo-root> fetch origin`
          - `git -C <repo-root> worktree add <repo-root>/wt/$1 -b ab/$1 origin/main`
            (use the actual default branch if it is not `main`)
        - After creation, confirm with `git -C <repo-root> worktree list` and report the
          absolute worktree path so it can be used with `/in-worktree`.
        - Do NOT edit any files or start work; only create the worktree.
      '';

      in-worktree = ''
        ---
        description: Run a command scoped to a worktree path without cd prompts
        ---

        # Run In Worktree

        Run a command inside a worktree without changing the shell's working directory.

        **Worktree:** `$1`
        **Command:** `$2`

        ## Rules

        - Resolve `$1` to an absolute path. If it is a bare name, treat it as
          `<repo-root>/wt/$1`.
        - Never use a bare `cd`.
          - For git operations, use `git -C "<abs-worktree>" ...`.
          - For build/test, prefer the repo's already-allowlisted Makefile targets
            (e.g. `make -C "<abs-worktree>" build`, `make -C "<abs-worktree>" test`)
            over a `cd && go ...` subshell, so no permission prompt is triggered.
        - Report the command's output and exit status. Do not modify files unless `$2`
          itself does so.
      '';

      update-configuration = ''
        ---
        description: Update the agent configuration settings
        ---

        # Update Agent Configuration

        Make changes to Claude's permissions, skills, or other global configuration parameters.

        ## Rules

        - Your configuration lives in ~/code/github.com/akatch/nix-config/home-manager/claude
        - Commands are set in commands.nix
        - Everything else is configured in settings.nix, 
      '';
    };
  };
}
