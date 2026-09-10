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
    };
  };
}
