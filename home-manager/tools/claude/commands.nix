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

      update-nix-config = ''
        ---
        description: Update the agent configuration settings
        ---

        # Update Agent Configuration

        Make changes to Claude's permissions, skills, or other global configuration parameters.

        ## Rules

        - Your configuration lives in ~/code/github.com/akatch/nix-config/home-manager/tools/claude
        - `commands.nix` — slash commands and skills, each a nix `'''` string keyed by command name
        - `settings.nix` — `programs.claude-code.settings`: permissions allow/deny, output style, hooks
        - `mcp-servers.nix` — `programs.claude-code.mcpServers` entries
        - `default.nix` — imports the above, plus `home.packages` and session variables
        - Skill bodies are nix `'''` strings: a literal `'''` or `''${` inside one breaks the build.
          Escape a literal two-quote sequence as three quotes, and a literal dollar-brace as
          `''${`. Always check with `nix-instantiate --parse <file>` after editing.
        - Never edit ~/.claude directly — it is generated from this repo and changes there are lost
          on the next rebuild.
        - After editing, report that a rebuild (`home-manager switch`) is needed to apply it. Do not
          run the rebuild or commit unless asked.
      '';

      rootcause-pd = ''
        ---
        description: Root cause a PagerDuty incident from telemetry and put a concise summary on the clipboard
        ---

        # Root Cause PagerDuty Incident

        Root cause PagerDuty incident **$1** using observability data, then draft a summary for the incident and copy it to the clipboard.

        ## Task

        1. Pull the incident with the PagerDuty MCP server (`get_incident`, then `list_alerts_from_incident`).
           - `list_alerts_from_incident` needs the *incident ID* (eg Q063SMA4HKXRJM), not the incident number. Get it from `get_incident` first.
           - Read the alert's labels and annotations: they carry namespace, pod, cluster, region, the dashboard URL, the runbook URL, and the alert expression in `generator_url`.
        2. Check `get_past_incidents` to see whether this recurs and on what cadence. A daily or hourly repeat means the alert is firing on the tail of a permanent condition, not a new event.
        3. Identify the datasource from the alert's `generator_url` / dashboard URL, then confirm with `list_datasources`. Match the region (VictoriaMetrics US-EAST, US-WEST, EU-SOUTH; Loki US-EAST etc).
        4. Establish the failure mode before theorizing. For a restart or crashloop, go straight to `kube_pod_container_status_last_terminated_reason` for the real kill reason.
           - `last_terminated_reason` is a sticky gauge: it persists long after the event and says nothing about *when*. Before blaming it, confirm the pod name matches the workload you're chasing and that `kube_pod_container_status_restarts_total` actually moved in your window. A flat restart count means the process never died and the reason is stale.
           - Not every stall is a kill. If the process is alive and serving traffic while work stops, look for a component that failed *inside* it — a Kafka Connect task, a worker thread, a consumer — rather than a container-level cause.
        5. Prove the mechanism with a metric that ties the symptom to a specific limit or threshold, and quote the actual numbers.
        6. Explicitly rule out the plausible alternatives, and say in the writeup which ones you eliminated and how.
        7. Pull logs from the matching Loki datasource around the event window. Note that sparse logs are themselves a signal: a cleanly exiting process logs shutdown messages, an OOM kill does not.
        8. Check whether the problem is specific to this workload or fleet-wide, by comparing the same metric across peers. This decides whether the fix is one config change or a systemic ticket.
        9. Present the root cause with the evidence chain, then draft the summary and copy it to the clipboard.

        ## Diagnostic rules

        - Query the observability knowledge base before running metric queries, per the o11yops server instructions.
        - Start with a narrow time range and widen only as needed. Prefer instant queries when a single point answers the question.
        - Always aggregate with `max()` / `sum()` / `topk()`. Raw selectors across a churning workload return thousands of series and blow the token limit.
        - Beware summing a gauge across pod generations: `sum(vm_promscrape_active_scrapers)` over 190 dead pods reports a nonsense total. Use `max by (pod)` or scope to the live pod.
        - Distinguish steady state from transient peaks. A healthy baseline with a short spike into a limit still kills the process, and a 60s scrape interval will usually miss the true peak.
        - Correlate `go_memstats_heap_inuse_bytes` with `container_memory_working_set_bytes` against `kube_pod_container_resource_limits` for memory faults.
        - Goroutine count discriminates causes: hundreds means a leak or thundering herd, one or two means a single large allocation.
        - A sidecar dying alongside the main container points at a cgroup-level kill, not an application fault.
        - Count affected pods with `count(count by (pod) (...))` to reveal churn the alert text understates.
        - Parent-level health often lies about children. Kafka Connect reports `kafka_connect_connector_status` RUNNING while every task in `kafka_connect_connector_task_status` is `failed`. Check the child/task metric, not just the parent.
        - For consumer lag, separate "slow" from "stopped": chart the committed offset itself. A frozen offset with lag rising at the produce rate is a hard stall, not backpressure. A commit-sequence counter resetting to 1 means tasks were torn down and re-failed.
        - A flat low value is not proof of health if the input is also idle. Confirm a topic or endpoint is actually busy before reading its zero as good news.
        - Sparse or single-purpose logs are evidence. If every line in the failure window is a health probe, the failure path never logged to stdout — say so and note where the detail does live (eg a REST status endpoint, whose response size hints at how much is hidden there).

        ## Summary rules

        - Lead with the root cause in the first clause of the first sentence.
        - Keep sentences short — one claim each. Never chain clauses with semicolons or a trailing
          "and the durable fix is..." just to satisfy a length target. Readability beats compression.
        - Structure as short paragraphs, one idea per paragraph, blank line between: root cause;
          the evidence that proves it; what was ruled out and how; blast radius and why it went
          unnoticed; anything unproven; the fixes. Omit a paragraph that has nothing to say.
        - Aim for under ~250 words. If the evidence genuinely needs more, spend the words rather
          than compressing into run-on sentences — but cut redundant detail first.
        - Cite specific measured values, not adjectives. Name the metric that proves it.
        - State what was ruled out, and the observation that eliminated it.
        - Say whether it is isolated or systemic, and give the immediate fix plus the durable fix.
        - Call out any detection gap: if the symptom that paged is downstream of the real failure,
          say what should have alerted instead.
        - Separate proven from inferred. If the triggering error was never captured, say so and
          name where it still lives.
        - No emojis, no check marks, no preamble, no sign-off. Plain prose that reads as an engineer's incident note.
        - Do not mention Claude, AI, or that the analysis was generated.

        ## Clipboard

        - Write the summary to the session scratchpad directory, then `pbcopy < <file>`.
        - Do not use echo, heredocs, or shell redirects to author the text; use the Write tool.
        - Verify with `pbpaste | wc -c` and report the byte count so UTF-8 punctuation is confirmed intact.

        ## Rules

        - Keep responses CONCISE and SCOPED
        - **Never post to PagerDuty.** Do not call `add_note_to_incident`, `manage_incidents`, or any other write tool. Draft only, copy to clipboard, and let me paste it.
        - Read-only PagerDuty and observability queries are fine without asking.
        - Do not change any code or config as part of root causing. Recommend the fix and name the file, but wait for confirmation before editing.
        - If evidence is inconclusive, say so plainly rather than presenting a confident guess. Distinguish what is proven from what is inferred.
        - Include the incident URL and relevant doc links with the final writeup.
      '';
    };
  };
}
