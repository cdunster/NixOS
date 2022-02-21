# Configure Neovim using home-manager.
{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraConfig = ''
    lua require('statusline')

    "Show relative linenumbers when focused.
    :augroup numbertoggle
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    :augroup END

    set ignorecase              "Enable case insensitive matching.
    set smartcase               "Enable smart-case matching (match case insensitively unless upper-case used).
    set tabstop=4               "Size of a tab.
    set softtabstop=4           "See multiple spaces as a tab.
    set expandtab               "Converts tabs to spaces.
    set shiftwidth=4            "Auto-indented width.
    set number relativenumber   "Enable line numbers.
    set termguicolors           "Enable full GUI colours in the terminal.
    set mouse=a                 "Enable the mouse for all modes.
    set clipboard+=unnamedplus  "Use the system clipboard.
    set scrolloff=4             "Context lines around cursor when scrolling.
    set spell spelllang=en_gb   "Enable spell checking.
    set list lcs+=space:·       "Show whitespace characters.
    set hidden                  "Keep buffers open in the background.
    set signcolumn=yes          "Always show the signcolumn.
    set nohlsearch              "Disable highlighting the search results.
    set nowrap                  "Don't wrap long lines onto multiple lines.
    set timeoutlen=300          "Set the time to wait for a mapped sequence to complete.
    set updatetime=300          "Better user experience.
    set wildmode=longest,list   "Enable bash-like tab completions.
    let g:mapleader=' '		"Set <SPC> to be the leader key for keybindings.

    colorscheme tokyonight
    '';
    plugins = with pkgs.vimPlugins; [
      # Telescope
      telescope-nvim
      plenary-nvim

      # Git
      vim-fugitive
      { plugin = gitsigns-nvim;
        config = "lua require('config.gitsigns').config()";
      }

      # WhichKey
      { plugin = which-key-nvim;
        config = ''
        lua << EOF
        require("which-key").setup {
            plugins = { spelling = true },
            key_labels = { ["<leader>"] = "SPC", ["<space>"] = "SPC" },
            layout = { spacing = 5 },
        }
        EOF
        '';
      }

      # Treesitter
      { plugin = nvim-treesitter;
        config = "lua require('config.treesitter').config()";
      }
      nvim-treesitter-textobjects

      # LSP
      { plugin = nvim-lspconfig;
        config = "lua require('config.lsp').config()";
      }

      # Autocomplete and Snippets
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-spell
      cmp-vsnip
      vim-vsnip
      { plugin = nvim-cmp;
        config = "lua require('config.cmp').config()";
      }

      # Comment-out lines
      vim-commentary

      # Colour schemes
      tokyonight-nvim
    ];
  };

  xdg.configFile."nvim/lua".source = ./nvim/lua;
}
