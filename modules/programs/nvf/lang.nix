{pkgs, ...}: {
  programs.nvf.settings.vim = {
    treesitter = {
      grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        typescript
      ];
    };

    autocomplete = {
      nvim-cmp = {
        enable = true;
      };
    };

    lsp = {
      enable = true;
    };

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      java.enable = true;

      ts.enable = true;
      svelte.enable = true;
      css.enable = true;

      clang.enable = true;
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

    # indent nix files with two spaces
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
  };
}
