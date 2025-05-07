{
  programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        noExitOnCtrlC = true;
        ui = {
          defaultsToFullScreen = true;
          enableMouse = true;
          headless = true;
          logoless = true;
          skin = "oceans";
        };
        logger = {
          textWrap = true;
        };
      };
    };
    skins = {
      oceans = {
        k9s = {
          body = {
            fgColor = "#5f8700";
            bgColor = "default";
            logoColor = "#5f8700";
          };

          info = {
            fgColor = "#5faf00";
            sectionColor = "#4e4e4e";
          };

          frame = {
            border = {
              fgColor = "#303030";
              focusColor = "#5f8700";
            };

            menu = {
              fgColor = "#4e4e4e";
              keyColor =  "#5faf00";
              numKeyColor = "#ffaf00";
            };

            crumbs = {
              fgColor = "#5faf00";
              bgColor = "default";
              activeColor = "#262626";
            };

            status = {
              newColor = "steelblue";
              modifyColor = "yellow";
              addColor = "lightskyblue";
              errorColor = "#ff8700";
              highlightcolor = "royalblue";
              killColor = "magenta";
              completedColor = "blue";
            };

            title = {
              fgColor = "#5faf00";
              bgColor = "default";
              highlightColor = "skyblue";
              counterColor = "slateblue";
              filterColor = "default";
            };

          };
          views = {
            table = {
              fgColor = "#5faf00";
              bgColor = "default";
              cursorColor = "aqua";
              header = {
                fgColor = "#5faf00";
                bgColor = "default";
              };
            };

            header = {
              fgColor = "#5faf00";
              bgColor = "default";
              sorterColor = "#faff00";
            };

            yaml = {
              keyColor = "cyan";
              colonColor = "green";
              fgColor = "default";
              valueColor = "#767676";
            };

            logs = {
              fgColor = "default";
              bgColor = "default";
            };
          };
        };
      };
    };
  };
}
