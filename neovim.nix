{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraConfig = ''
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
      set spell spelllang=en_gb   "Enable spell checking. Set language to proper English.
      set list lcs+=space:·       "Show whitespace characters.
      set hidden                  "Keep buffers open in the background.
      set signcolumn=yes          "Always show the signcolumn.
      set nohlsearch              "Disable highlighting the search results.
      set nowrap                  "Don't wrap long lines onto multiple lines.
      set timeoutlen=300          "Set the time to wait for a mapped sequence to complete.
      set updatetime=300          "Better user experience.
      set wildmode=longest,list   "Enable bash-like tab completions.
      let g:mapleader=' '         "Set <SPC> to be the leader key for keybindings.
      let g:maplocalleader=','    "Set ',' to be the local leader key for language specific keybindings.

      lua << EOF
        require("which-key").register({
            [">"] = { ">gv", "Increase indent" },
            ["<"] = { "<gv", "Decrease indent" },
        }, { mode = "v" })
      EOF
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
          config = "require('config.telescope').config()";
        }
        plenary-nvim
        telescope-ui-select-nvim

        # Git
        {
          plugin = vim-fugitive;
          type = "lua";
          config = "require('config.fugitive').config()";
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = "require('config.gitsigns').config()";
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
            }'';
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
              tree-sitter-yaml
              tree-sitter-markdown
            ]
          ));
          type = "lua";
          config = "require('config.treesitter').config()";
        }
        nvim-treesitter-textobjects

        # LSP
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = "require('config.lsp').config()";
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
          config = "require('config.cmp').config()";
        }

        # Comment-out lines
        vim-commentary

        # Better motions for words i.e. camelCase, snake_case, etc.
        vim-wordmotion

        # Better spellchecking (supports camelCase, snake_case, etc.).
        {
          plugin = vim-spelunker;
          type = "lua";
          config = "require('config.spelunker').config()";
        }

        # Better statusline. Requires devicons.
        lualine-lsp-progress
        {
          plugin = lualine-nvim;
          type = "lua";
          config = "require('config.lualine').config()";
        }

        # Font icons in Neovim.
        {
          plugin = nvim-web-devicons;
          type = "lua";
          config = "require('nvim-web-devicons').setup()";
        }

        # Colour schemes
        tokyonight-nvim
        {
          plugin = dracula-vim;
          type = "viml";
          config = "colorscheme dracula";
        }

        # Support PICO-8 development
        pico8-vim

        # VimWiki for writting wikis and notes in markdown.
        {
          plugin = vimwiki;
          type = "lua";
          config = "require('config.vimwiki').config()";
        }
      ];
  };

  xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;
  xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

  home.sessionVariables.EDITOR = "${config.home.homeDirectory}/.nix-profile/bin/nvim";
}
