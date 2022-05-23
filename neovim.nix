# Configure Neovim using home-manager.
{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua require('config.statusline')

      "Show relative linenumbers when focused.
      :augroup numbertoggle
      :  autocmd!
      :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
      :augroup END

      "Format Rust files on save.
      autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

      set ignorecase              "Enable case insensitive matching.
      set smartcase               "Enable smart-case matching (match case insensitively unless upper-case used).
      set tabstop=2               "Size of a tab.
      set softtabstop=2           "See multiple spaces as a tab.
      set expandtab               "Converts tabs to spaces.
      set shiftwidth=2            "Auto-indented width.
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
      let g:mapleader=' '         "Set <SPC> to be the leader key for keybindings.

      colorscheme tokyonight
    '';
    plugins =
      with pkgs.vimPlugins;
      with pkgs.vimUtils;
      let
        vim-spelunker = buildVimPlugin {
          name = "vim-spelunker";
          src = pkgs.fetchFromGitHub {
            owner = "kamykn";
            repo = "spelunker.vim";
            rev = "a0bc530f62798bbe053905555a4aa9ed713485eb";
            sha256 = "/1MN2KU5+rJhjt7FALvvwmTKRk3n29tU/XQdt1Q5OTE=";
          };
        };
        pico8-vim = buildVimPlugin {
          name = "PICO-8.vim";
          src = pkgs.fetchFromGitHub {
            owner = "Bakudankun";
            repo = "PICO-8.vim";
            rev = "4bd67ee62f3650c8d107eab7a9878defb903f0e2";
            sha256 = "a4/A6Ja7hl44+vLx/27/CepsfCenEOapf125y5bArVY=";
          };
        };
      in
      [
        # Automatic session management.
        vim-obsession

        # Telescope
        {
          plugin = telescope-nvim;
          type = "lua";
          config = "require('config.telescope').config()\n";
        }
        plenary-nvim
        telescope-ui-select-nvim

        # Git
        {
          plugin = vim-fugitive;
          type = "lua";
          config = "require('config.fugitive').config()\n";
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = "require('config.gitsigns').config()\n";
        }

        # WhichKey
        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
            require("which-key").setup {
                plugins = { spelling = true },
                key_labels = { ["<leader>"] = "SPC", ["<space>"] = "SPC" },
                layout = { spacing = 5 },
            }
          '';
        }

        # Treesitter
        {
          plugin = (nvim-treesitter.withPlugins (
            plugins: with plugins; [
              tree-sitter-nix
              tree-sitter-c
              tree-sitter-rust
              tree-sitter-fish
              tree-sitter-python
              tree-sitter-lua
              tree-sitter-css
            ]
          ));
          type = "lua";
          config = "require('config.treesitter').config()\n";
        }
        nvim-treesitter-textobjects

        # LSP
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = "require('config.lsp').config()\n";
        }
        lsp_signature-nvim
        rust-tools-nvim # Advanced LSP features for Rust.

        # Autocomplete and Snippets
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-spell
        cmp-vsnip
        vim-vsnip
        {
          plugin = nvim-cmp;
          type = "lua";
          config = "require('config.cmp').config()\n";
        }

        # Comment-out lines
        vim-commentary

        # Better motions for words i.e. camelCase, snake_case, etc.
        vim-wordmotion

        # Better spellchecking (supports camelCase, snake_case, etc.).
        {
          plugin = vim-spelunker;
          type = "lua";
          config = "require('config.spelunker').config()\n";
        }

        # Colour schemes
        tokyonight-nvim

        # Support PICO-8 development
        pico8-vim
      ];
  };

  xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;

  home.sessionVariables.EDITOR = "${pkgs.neovim}/bin/nvim";
}
