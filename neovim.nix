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
        neotest-rust = buildVimPlugin {
          name = "neotest-rust";
          src = pkgs.fetchFromGitHub {
            owner = "cdunster";
            repo = "neotest-rust";
            rev = "0c11d5a0e966d660048e0153cbe31d021521cf91";
            hash = "sha256-YiP1AOyI22sBk+5o502cs5Mu6lxgs00Nis2rlDm6TuA=";
          };
        };
        vim-godot = buildVimPlugin {
          name = "vim-godot";
          src = pkgs.fetchFromGitHub {
            owner = "habamax";
            repo = "vim-godot";
            rev = "d748a46be5195256f6b2c767ef32de87b05ae8f7";
            sha256 = "0icsy983ivw409afv19mw2qi7axil8a21r0dwlfxcj9wqcaf1cbj";
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
              tree-sitter-gdscript
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
        rustaceanvim # Advanced LSP features for Rust.

        # Display LSP progress in bottom right.
        {
          plugin = fidget-nvim;
          type = "lua";
          config = "require('fidget').setup()";
        }

        # Debug applications via the Debug Adaptor Protocol.
        {
          plugin = vimspector;
          config = "let g:vimspector_enable_mappings = 'HUMAN'";
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

        # Better GDScript support for the Godot engine.
        {
          plugin = vim-godot;
          type = "lua";
          config = "require('plugins.vim-godot').config()";
        }

        # Horizontally centre buffer content in floating window.
        {
          plugin = zen-mode-nvim;
          type = "lua";
          config = "require('plugins.zen-mode').config()";
        }

        # Highlight only code being worked on (works with zen-mode).
        twilight-nvim

        # Edit filesystem in a buffer.
        {
          plugin = oil-nvim;
          type = "lua";
          config = "require('oil').setup()";
        }
      ];
  };

  xdg.configFile."nvim/lua/plugins".source = ./nvim/lua/plugins;
  xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;
  xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

  # This is a bit meta and very hacky but I want the spell file to be writeable.
  xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/nvim/spell/en.utf-8.add";
}
