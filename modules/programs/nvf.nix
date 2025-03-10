{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "oxocarbon"; # temporary; nvf target in stylix is not in release-24.11 branch yet
          style = "dark";
        };

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
        };
         
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
                                
        lineNumberMode = "number";

        visuals = {
          indent-blankline = {
            enable = true;
          };
        };

        options = {
          shiftwidth = 2;
          tabstop = 2;
        };

        mini = {
          # text editing
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

      };
    };
  };
}
