
{
  pkgs,
  ...
}: {
  systemd.services."bot" = 
  let
    project_dir = "/home/al/code/github.com/akatch/go-chat-bot/build";
  in
  {
    description = "IRC bot";
    environment = {
      IRC_SERVER = "irc.synirc.net";
      IRC_PORT = "7001";
      IRC_CHANNELS = "#pharyngula";
      IRC_NICK = "DuncanIdaho";
      IRC_PASSWORD = "";
      IRC_USETLS = "true";
      DEBUG = "";
    };
    serviceConfig = {
      ExecStart  = "${project_dir}/bot";
      Restart = "on-failure";
      Type = "exec";
      User = "al";
    };
    wantedBy = [ "default.target" ];
  };
}
