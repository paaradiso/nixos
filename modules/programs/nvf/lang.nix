{pkgs, ...}: {
  environment.systemPackages = with pkgs; [rustywind];
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
      gleam.enable = true;
    };
    formatter = {
      conform-nvim = {
        enable = true;
        setupOpts = {
          format_on_save = {
            lsp_format = "first";
            timeout_ms = 500;
          };
          formatters = {
            rustywind_gleam = {
              command = "${pkgs.rustywind}/bin/rustywind";
              args = [
                "--custom-regex"
                "attribute\\.class\\([\\s\\S]*?[\\\"\\']([\\s\\S]*?)[\\\"\\'][\\s\\S]*?\\)"
                "--stdin"
              ];
              stdin = true;
            };
          };
          formatters_by_ft = {
            nix = ["alejandra"];
            javascript = ["prettierd"];
            typescript = ["prettierd"];
            css = ["prettierd"];
            c = ["clang-format"];
            cpp = ["clang-format"];
            sql = ["pg_format"];
            gleam = ["rustywind_gleam"];
          };
        };
      };
    };
    debugger = {
      nvim-dap = {
        enable = true;
        ui.enable = true;
      };
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
  };
}
