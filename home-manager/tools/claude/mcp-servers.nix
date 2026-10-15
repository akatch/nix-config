{
  programs.claude-code = {
    mcpServers = {
      stargate-pagerduty = {
        type = "http";
        url = "https://stargate.us-west.core-internal.ingress.int.coreweave.com/pagerduty/mcp";
      };
      mission-control-mcp = {
        type = "http";
        url = "https://mission-control.us-west.core-internal.ingress.int.coreweave.com/mcp";
      };
      # GitHub's remote MCP publishes no registration_endpoint, so Claude Code's
      # OAuth path fails with "does not support dynamic client registration".
      # A PAT in the Authorization header bypasses OAuth entirely.
      # GITHUB_PAT is expanded at config load; keep the token out of the Nix store.
      github = {
        type = "http";
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer \${GITHUB_PAT}";
        };
      };
    };
  };
}
