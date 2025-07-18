{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        telescope.enable = true;

        # lineNumberMode = "number";

        autocomplete = {
          nvim-cmp = {
            enable = true;
          };
        };

        languages = {
          enableTreesitter = true;

          nix.enable = true;
          java.enable = true;

          ts.enable = true;
          svelte.enable = true;
          css.enable = true;
        };

        treesitter = {
          grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            typescript
          ];
        };

        lsp = {
          enable = true;
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
                javascript = ["prettierd"];
                typescript = ["prettierd"];
                css = ["prettierd"];
              };
            };
          };
        };

        visuals = {
          indent-blankline.enable = true;
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
          # pane manipulation and navigation
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
          {
            key = "<C-Leader>;";
            mode = "n";
            silent = true;
            action = "<C-w><";
          }
          {
            key = "<C-Leader>'";
            mode = "n";
            silent = true;
            action = "<C-w>>";
          }
          {
            key = "<C-Leader>/";
            mode = "n";
            silent = true;
            action = "<C-w>+";
          }
          {
            key = "<C-Leader>[";
            mode = "n";
            silent = true;
            action = "<C-w>-";
          }
          {
            key = "<C-Leader>=";
            mode = "n";
            silent = true;
            action = "<C-w>=";
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
          # oil-nvim
          {
            key = "<Leader>o";
            mode = "n";
            silent = true;
            action = "<cmd>lua vim.cmd((vim.bo.filetype == 'oil') and 'bd' or 'Oil')<CR>";
            desc = "Toggle oil-nvim";
          }

          ###
          # misc
          {
            key = "<Leader>/";
            mode = "n";
            silent = true;
            action = "<cmd>nohlsearch<cr>";
          }
          ###
          # nixos
          {
            key = "<Leader>ns";
            mode = "n";
            silent = true;
            action = "<cmd>ToggleTerm TermExec cmd='sudo nixos-rebuild switch'<CR>";
            desc = "NixOS rebuild switch";
          }
          ###
          # open error window
          {
            key = "<Leader>E";
            mode = "n";
            silent = true;
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
            desc = "Open floating diagnostic window at cursor";
          }
        ];
      };
    };
  };
}
