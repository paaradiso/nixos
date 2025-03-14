{config, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        # lineNumberMode = "number";

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          java.enable = true;
        };

        formatter = {
          conform-nvim = {
            enable = true;
            setupOpts = {
              format_on_save = {
                lsp_format = "fallback";
                timeout_ms = 500;
              };
              formatters_by_ft = {
                nix = ["alejandra"];
              };
            };
          };
        };

        visuals = {
          indent-blankline = {
            enable = true;
          };
        };

        options = {
          shiftwidth = 4;
          tabstop = 4;
          clipboard = "unnamedplus";
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

        assistant = {
          copilot = {
            enable = true;
            cmp.enable = true;
          };
        };

        terminal = {
          toggleterm = {
            enable = true;

            lazygit.enable = true;
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
          files.enable = true;

          # appearance
          animate.enable = true;
          statusline.enable = true;
          tabline.enable = true;
        };

        augroups = [
          {
            name = "setIndent";
            clear = true;
          }
        ];

        autocmds = [
          {
            event = ["FileType"];
            pattern = ["nix"];
            command = "setlocal shiftwidth=2 tabstop=2";
            group = "setIndent";
          }
        ];

        keymaps = [
          # buffer
          {
            key = "<Tab>";
            mode = "n";
            silent = true;
            action = "<cmd>bnext<CR>";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            silent = true;
            action = "<cmd>bprev<CR>";
          }
          ###
          # telescope
          {
            key = "<Leader>ts";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope commands<CR>";
          }
          ###
          # arrows for pane navigation
          {
            key = "<Left>";
            mode = "n";
            silent = true;
            action = "<C-w>h";
          }
          {
            key = "<Down>";
            mode = "n";
            silent = true;
            action = "<C-w>j";
          }
          {
            key = "<Up>";
            mode = "n";
            silent = true;
            action = "<C-w>k";
          }
          {
            key = "<Right>";
            mode = "n";
            silent = true;
            action = "<C-w>l";
          }
          ###
          # neo=tree
          {
            key = "<Leader>e";
            mode = "n";
            silent = true;
            action = "<cmd>Neotree toggle<CR>";
          }
          ###
          # misc
          {
            key = "<Leader>/";
            mode = "n";
            silent = true;
            action = "<cmd>nohlsearch<cr>";
          }
        ];
      };
    };
  };
}
