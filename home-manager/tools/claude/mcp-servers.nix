{
  programs.claude-code = {
    mcpServers = {
      atlassian = {
        type = "http";
        url = "https://mcp.atlassian.com/v1/mcp";
      };
      github = {
        type = "http";
        url = "https://api.githubcopilot.com/mcp";
        headers = {
          Authorization = "Bearer $GITHUB_PAT";
        };
      };
      glean_default = {
        type = "http";
        url = "https://coreweave-be.glean.com/mcp/default";
      };
      o11yops = {
        type = "http";
        url = "https://o11yops.us-west.core-internal.ingress.int.coreweave.com/mcp";
      };
      pagerduty = {
        command = "uvx";
        url = "https://mcp.pagerduty.com/mcp";
        args = [
          "pagerduty-mcp-server"
        ];
        env = {
          PAGERDUTY_USER_API_TOKEN = builtins.getEnv "PAGERDUTY_API_TOKEN";
        };
      };
    };
  };
}
