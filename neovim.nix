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
    set nospell spelllang=en_gb "Disable built-in spell checking (replaced by plugin).
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
    plugins =
    with pkgs.vimPlugins;
    let
      vim-spelunker = pkgs.vimUtils.buildVimPlugin {
        name = "vim-spelunker";
        src = pkgs.fetchFromGitHub {
          owner = "kamykn";
          repo = "spelunker.vim";
          rev = "a0bc530f62798bbe053905555a4aa9ed713485eb";
          sha256 = "/1MN2KU5+rJhjt7FALvvwmTKRk3n29tU/XQdt1Q5OTE=";
        };
      };
    in
    [
      # Automatic session management.
      vim-obsession

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
      { plugin = (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-nix
            tree-sitter-c
            tree-sitter-rust
            tree-sitter-fish
          ]
        ));
        config = "lua require('config.treesitter').config()";
      }
      nvim-treesitter-textobjects

      # LSP
      { plugin = nvim-lspconfig;
        config = "lua require('config.lsp').config()";
      }
      lsp_signature-nvim

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

      # Better motions for words i.e. camelCase, snake_case, etc.
      vim-wordmotion

      # Better spellchecking (supports camelCase, snake_case, etc.).
      { plugin = vim-spelunker;
        config = "lua require('config.spelunker').config()";
      }

      # Colour schemes
      tokyonight-nvim
    ];
  };

  xdg.configFile."nvim/lua".source = ./nvim/lua;

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
