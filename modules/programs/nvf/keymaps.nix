{
  programs.nvf.settings.vim.keymaps = [
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
}
