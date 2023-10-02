{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaConfig = ''
      require('config.custom_bindings')
      require('config.settings')
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
        fidget-nvim-legacy = buildVimPlugin {
          name = "fidget.nvim";
          version = "legacy";
          src = pkgs.fetchFromGitHub {
            owner = "j-hui";
            repo = "fidget.nvim";
            rev = "0ba1e16d07627532b6cae915cc992ecac249fb97";
            sha256 = "01rrjxlg4xjfs8la0cfcnf5z36s5fdxqzfs4mc0zdz1bn5z60qmf";
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
          config = "require('plugins.telescope').config()";
        }
        plenary-nvim
        telescope-ui-select-nvim

        # Git
        {
          plugin = vim-fugitive;
          type = "lua";
          config = "require('plugins.fugitive').config()";
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = "require('plugins.gitsigns').config()";
        }

        # WhichKey
        {
          plugin = which-key-nvim;
          type = "lua";
          config = ''
            require('which-key').setup {
                plugins = { spelling = true },
                key_labels = { ['<leader>'] = 'SPC', ['<space>'] = 'SPC' },
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
              tree-sitter-bash
            ]
          ));
          type = "lua";
          config = "require('plugins.treesitter').config()";
        }
        nvim-treesitter-textobjects

        # LSP
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = "require('plugins.lsp').config()";
        }
        lsp_signature-nvim
        rust-tools-nvim # Advanced LSP features for Rust.

        # Display LSP progress in bottom right.
        {
          plugin = fidget-nvim-legacy;
          type = "lua";
          config = "require('fidget').setup{ text = { spinner = 'dots_pulse' } }";
        }

        # Autocomplete and Snippets
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp-vsnip
        vim-vsnip
        {
          plugin = nvim-cmp;
          type = "lua";
          config = "require('plugins.cmp').config()";
        }

        # Comment-out lines
        vim-commentary

        # Better motions for words i.e. camelCase, snake_case, etc.
        vim-wordmotion

        # Run unit tests from within Neovim.
        {
          plugin = neotest;
          type = "lua";
          config = "require('plugins.neotest').config()";
        }
        neotest-rust # Add Rust support for neotest (above)
        nvim-coverage # Show coverage in the gutter

        # Better UI hooks for user input/output in nvim
        dressing-nvim

        # Better nvim notifications with a slick UI
        {
          plugin = nvim-notify;
          type = "lua";
          config = "require('plugins.notify').config()";
        }

        # Better spellchecking (supports camelCase, snake_case, etc.).
        {
          plugin = vim-spelunker;
          type = "lua";
          config = "require('plugins.spelunker').config()";
        }

        # Better statusline. Requires devicons.
        {
          plugin = lualine-nvim;
          type = "lua";
          config = "require('plugins.lualine').config()";
        }

        # Font icons in Neovim.
        {
          plugin = nvim-web-devicons;
          type = "lua";
          config = "require('nvim-web-devicons').setup()";
        }

        # Colour schemes
        {
          plugin = dracula-nvim;
          type = "lua";
          config = "vim.cmd.colorscheme('dracula')";
        }
      ];
  };

  xdg.configFile."nvim/lua/plugins".source = ./nvim/lua/plugins;
  xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;
  xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

  # This is a bit meta and very hacky but I want the spell file to be writeable.
  xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/nvim/spell/en.utf-8.add";
}
