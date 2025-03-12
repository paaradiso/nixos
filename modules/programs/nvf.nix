{config, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lineNumberMode = "number";

        theme = {
          enable = true;
          name = "base16"; # temporary; nvf target in stylix is not in release-24.11 branch yet
          base16-colors = {
            inherit
              (config.lib.stylix.colors.withHashtag)
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          };
          style = "dark";
        };

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
          shiftwidth = 2;
          tabstop = 2;
        };

        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };

        ui = {
          noice.enable = true;
          nvim-ufo.enable = true;
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

        keymaps = [
          # buffer
          {
            key = "<Tab>";
            mode = "n";
            silent = true;
            action = ":bnext<CR>";
          }
          {
            key = "<S-Tab>";
            mode = "n";
            silent = true;
            action = ":bprev<CR>";
          }
          ###
          # telescope
          {
            key = "<Leader>ts";
            mode = "n";
            silent = true;
            action = ":Telescope commands<CR>";
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
        ];
      };
    };
  };
}
