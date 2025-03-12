{config, ...}: {
  # INFO: Applying Stylix's theme
  programs.hyprpanel.override.theme = with config.lib.stylix.colors.withHashtag; {
    bar = {
      background = base00;
      border.color = base0D;
      hover = base03;
      icon = base0D;
      icon_background = base02;
      style = "default";
      text = base0D;
      buttons = {
        background = base02;
        borderColor = base0D;
        battery = {
          background = base02;
          border = base0A;
          icon = base0A;
          icon_background = base0A;
          text = base0A;
        };
        bluetooth = {
          background = base02;
          border = base0C;
          icon = base0C;
          icon_background = base0C;
          text = base0C;
        };
        clock = {
          background = base02;
          border = base05;
          icon = base05;
          icon_background = base05;
          text = base05;
        };
        dashboard = {
          background = base02;
          border = base0D;
          icon = base0D;
        };
        media = {
          background = base02;
          border = base0D;
          icon = base0D;
          icon_background = base0D;
          text = base0D;
        };
        network = {
          background = base02;
          border = base0E;
          icon = base0E;
          icon_background = base0E;
          text = base0E;
        };
        notifications = {
          background = base02;
          border = base0D;
          icon = base0D;
          icon_background = base0D;
          total = base0D;
        };
        systray = {
          background = base02;
          border = base0D;
          customIcon = base05;
        };
        volume = {
          background = base02;
          border = base0F;
          icon = base0F;
          icon_background = base0F;
          text = base0F;
        };
        windowtitle = {
          background = base02;
          border = base05;
          icon = base05;
          icon_background = base05;
          text = base05;
        };
        workspace = {
          active = base05;
          available = base0C;
          background = base02;
          border = base05;
          hover = base05;
          numbered_active_highlighted_text_color = base01;
          numbered_active_underline_color = base05;
          occupied = base06;
        };
        modules = {
          cava = {
            background = base02;
            border = base0C;
            icon = base0C;
            icon_background = base02;
            text = base0C;
          };
          cpu = {
            background = base02;
            border = base08;
            icon = base08;
            icon_background = base08;
            text = base08;
          };
          hypridle = {
            background = base02;
            border = base05;
            icon = base05;
            icon_background = base05;
            text = base05;
          };
          hyprsunset = {
            background = base02;
            border = base05;
            icon = base09;
            icon_background = base02;
            text = base09;
          };
          kbLayout = {
            background = base02;
            border = base0C;
            icon = base0C;
            icon_background = base0C;
            text = base0C;
          };
          microphone = {
            background = base02;
            border = base0C;
            icon = base0C;
            icon_background = base02;
            text = base0C;
          };
          netstat = {
            background = base02;
            border = base0C;
            icon = base0C;
            icon_background = base0C;
            text = base0C;
          };
          power = {
            background = base02;
            border = base08;
            icon = base08;
            icon_background = base08;
          };
          ram = {
            background = base02;
            border = base0A;
            icon = base0A;
            icon_background = base0A;
            text = base0A;
          };
          storage = {
            background = base02;
            border = base05;
            icon = base05;
            icon_background = base05;
            text = base05;
          };
          submap = {
            background = base02;
            border = base0C;
            icon = base0C;
            icon_background = base02;
            text = base0C;
          };
          updates = {
            background = base02;
            border = base0E;
            icon = base0E;
            icon_background = base0E;
            text = base0E;
          };
          weather = {
            background = base02;
            border = base0D;
            icon = base0D;
            icon_background = base0D;
            text = base0D;
          };
        };
      };
      menus = {
        background = base00;
        border.color = base02;
        buttons = {
          active = base0F;
          default = base0D;
          disabled = base05;
          text = base00;
        };
        cards = base01;
        check_radio_button = {
          active = base0D;
          background = base03;
        };
        dimtext = base05;
        dropdownmenu = {
          background = base00;
          divider = base01;
          text = base05;
        };
        feinttext = base02;
        iconbuttons = {
          active = base0D;
          passive = base05;
        };
        icons = {
          active = base0D;
          passive = base05;
        };
        label = base0D;
        listitems = {
          active = base0D;
          passive = base05;
        };
        menu = {
          battery = {
            background.color = base00;
            border.color = base02;
            card.color = base01;
            icons = {
              active = base0A;
              passive = base04;
            };
            label.color = base0A;
            listitems = {
              active = base0A;
              passive = base05;
            };
            slider = {
              background = base05;
              backgroundhover = base03;
              primary = base0A;
              puck = base04;
            };
            text = base05;
          };
          bluetooth = {
            background.color = base00;
            border.color = base02;
            card.color = base01;
            iconbutton = {
              active = base0C;
              passive = base05;
            };
            icons = {
              active = base0C;
              passive = base04;
            };
            label.color = base0C;
            listitems = {
              active = base0C;
              passive = base05;
            };
            scroller.color = base0C;
            status = base04;
            switch = {
              disabled = base03;
              enabled = base0C;
              puck = base04;
            };
            switch_divider = base03;
            text = base05;
          };
          clock = {
            background.color = base00;
            border.color = base02;
            calendar = {
              contextdays = base05;
              currentday = base05;
              days = base05;
              paginator = base0F;
              weekdays = base05;
              yearmonth = base0C;
            };
            card.color = base01;
            text = base05;
            time = {
              time = base05;
              timeperiod = base0C;
            };
            weather = {
              hourly = {
                icon = base05;
                temperature = base05;
                time = base05;
              };
              icon = base05;
              stats = base05;
              status = base0C;
              temperature = base05;
              thermometer = {
                cold = base0D;
                extremelycold = base0C;
                extremelyhot = base08;
                hot = base09;
                moderate = base0D;
              };
            };
          };
          dashboard = {
            background.color = base00;
            border.color = base02;
            card.color = base01;
            controls = {
              disabled = base05;
              bluetooth = {
                background = base0C;
                text = base00;
              };
              input = {
                background = base05;
                text = base00;
              };
              notifications = {
                background = base0A;
                text = base00;
              };
              volume = {
                background = base0F;
                text = base00;
              };
              wifi = {
                background = base0E;
                text = base00;
              };
            };
            directories = {
              left = {
                bottom.color = base0F;
                middle.color = base0A;
                top.color = base05;
              };
              right = {
                bottom.color = base0D;
                middle.color = base0E;
                top.color = base0C;
              };
            };
            monitors = {
              bar_background = base03;
              cpu = {
                bar = base08;
                icon = base0F;
                label = base0F;
              };
              disk = {
                bar = base06;
                icon = base05;
                label = base05;
              };
              gpu = {
                bar = base0B;
                icon = base0C;
                label = base0C;
              };
              ram = {
                bar = base0A;
                icon = base0A;
                label = base0A;
              };
            };
            powermenu = {
              confirmation = {
                background = base00;
                body = base05;
                border = base02;
                button_text = base00;
                card = base01;
                confirm = base0C;
                deny = base08;
                label = base0D;
              };
              logout = base0C;
              restart = base09;
              shutdown = base08;
              sleep = base0C;
            };
            profile.name = base05;
            shortcuts = {
              background = base0D;
              recording = base0C;
              text = base00;
            };
          };
          media = {
            album = base06;
            artist = base0C;
            background.color = base00;
            border.color = base02;
            buttons = {
              background = base0D;
              enabled = base0C;
              inactive = base05;
              text = base00;
            };
            card.color = base01;
            slider = {
              background = base05;
              backgroundhover = base03;
              primary = base05;
              puck = base04;
            };
            song = base0D;
            timestamp = base05;
          };
          network = {
            background.color = base00;
            border.color = base02;
            card.color = base01;
            iconbuttons = {
              active = base0E;
              passive = base05;
            };
            icons = {
              active = base0E;
              passive = base04;
            };
            label.color = base0E;
            listitems = {
              active = base0E;
              passive = base05;
            };
            scroller.color = base0E;
            status.color = base04;
            switch = {
              disabled = base03;
              enabled = base0E;
              puck = base04;
            };
            text = base05;
          };
          notification = {
            background = base00;
            border = base02;
            card = base01;
            clear = base08;
            label = base0D;
            no_notifications_label = base02;
            pager = {
              background = base00;
              button = base0D;
              label = base04;
            };
            scrollbar.color = base0D;
            switch = {
              disabled = base03;
              enabled = base0D;
              puck = base04;
            };
            switch_divider = base03;
          };
          power = {
            background.color = base00;
            border.color = base02;
            buttons = {
              logout = {
                background = base01;
                icon = base00;
                icon_background = base0C;
                text = base0C;
              };
              restart = {
                background = base01;
                icon = base00;
                icon_background = base09;
                text = base09;
              };
              shutdown = {
                background = base01;
                icon = base00;
                icon_background = base08;
                text = base08;
              };
              sleep = {
                background = base01;
                icon = base00;
                icon_background = base0C;
                text = base0C;
              };
            };
          };
          systray.dropdownmenu = {
            background = base00;
            divider = base01;
            text = base05;
          };
          volume = {
            text = base05;
            audio_slider = {
              background = base05;
              backgroundhover = base03;
              primary = base0F;
              puck = base05;
            };
            background.color = base00;
            border.color = base02;
            card.color = base01;
            iconbutton = {
              active = base0F;
              passive = base05;
            };
            icons = {
              active = base0F;
              passive = base04;
            };
            input_slider = {
              background = base05;
              backgroundhover = base03;
              primary = base0F;
              puck = base05;
            };
            label.color = base0F;
            listitems = {
              active = base0F;
              passive = base05;
            };
          };
        };
        popover = {
          background = base00;
          border = base00;
          text = base0D;
        };
        progressbar = {
          background = base03;
          foreground = base0D;
        };
        slider = {
          background = base05;
          backgroundhover = base03;
          primary = base0D;
          puck = base04;
        };
        switch = {
          disabled = base03;
          enabled = base0D;
          puck = base04;
        };
        tooltip = {
          background = base00;
          text = base05;
        };
      };
    };
    notification = {
      actions = {
        background = base0D;
        text = base01;
      };
      background = base00;
      border = base03;
      close_button = {
        background = base08;
        label = base00;
      };
      label = base0D;
      labelicon = base0D;
      text = base05;
      time = base03;
    };
    osd = {
      bar_color = base0D;
      bar_container = base00;
      bar_empty_color = base02;
      bar_overflow_color = base08;
      icon = base00;
      icon_container = base0D;
      label = base0D;
    };
  };
}
