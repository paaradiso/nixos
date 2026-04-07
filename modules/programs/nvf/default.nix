{pkgs, ...}: {
  imports = [./lang.nix ./keymaps.nix];

  environment.systemPackages = with pkgs; [wl-clipboard];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        telescope.enable = true;

        # lineNumberMode = "number";

        visuals = {
          indent-blankline.enable = true;
        };

        options = {
          shiftwidth = 4;
          tabstop = 4;
          clipboard = "unnamedplus";
        };

        clipboard = {
          registers = "unnamedplus";
          providers.wl-copy = {
            enable = true;
            package = pkgs.wl-clipboard;
          };
        };

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };

        ui = {
          noice.enable = true;
        };

        dashboard = {
          alpha = {
            enable = true;
            theme = "theta";
          };
        };

        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              # filesystem.hijack_netrw_behavior = "open_default", "disabled", "open_current"
            };
          };
        };

        utility = {
          oil-nvim = {
            enable = true;
            # setupOpts = {
            #
            # }
          };
        };

        # assistant = {
        #   copilot = {
        #     enable = true;
        #     cmp.enable = true;
        #   };
        # };

        terminal = {
          toggleterm = {
            enable = true;

            lazygit.enable = true;
          };
        };

        git = {
          gitsigns = {
            enable = true;
          };
        };

        mini = {
          # text editing
          ai.enable = true;
          comment.enable = true;
          move.enable = true;
          pairs.enable = true;
          surround.enable = true;

          # general workflow
          # files.enable = true;

          # appearance
          notify.enable = true;
          statusline.enable = true;
          tabline.enable = true;
        };
      };
    };
  };
}
