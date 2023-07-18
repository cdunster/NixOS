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
        pico8-vim = buildVimPlugin {
          name = "PICO-8.vim";
          src = pkgs.fetchFromGitHub {
            owner = "Bakudankun";
            repo = "PICO-8.vim";
            rev = "4bd67ee62f3650c8d107eab7a9878defb903f0e2";
            sha256 = "a4/A6Ja7hl44+vLx/27/CepsfCenEOapf125y5bArVY=";
          };
        };
        vim-asciidoctor = buildVimPlugin {
          name = "vim-asciidoctor";
          src = pkgs.fetchFromGitHub {
            owner = "habamax";
            repo = "vim-asciidoctor";
            rev = "f553311b5db03440eb8d7035434d0405e4a2c559";
            sha256 = "05sbipvsrv4zbgg6k0glr0syj9q5zipp6wylhffln6awq8r7n3j9";
          };
        };
        wiki-vim = buildVimPlugin {
          name = "wiki.vim";
          src = pkgs.fetchFromGitHub {
            owner = "lervag";
            repo = "wiki.vim";
            rev = "83761e3c2afc588dd9b99c67992b6fae3f6c7403";
            sha256 = "000cja95nypdzp8mhcbz2lm1kvm92anp3pycn7may4pc1i069r4l";
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

        # Better "alternative file" navigation
        {
          plugin = harpoon;
          type = "lua";
          config = "require('plugins.harpoon').config()";
        }

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
          plugin = fidget-nvim;
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
        tokyonight-nvim
        {
          plugin = dracula-nvim;
          type = "viml";
          config = "colorscheme dracula";
        }

        # Support PICO-8 development
        pico8-vim

        # Better syntax highlighting for asciidocs and other asciidoctor commands.
        {
          plugin = vim-asciidoctor;
          type = "lua";
          config = "require('plugins.vim-asciidoctor').config()";
        }

        # Write wikis, notes, and journal entries in a markup language
        {
          plugin = wiki-vim;
          type = "lua";
          config = "require('plugins.wikivim').config()";
        }
      ];
  };

  xdg.configFile."nvim/lua/plugins".source = ./nvim/lua/plugins;
  xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;
  xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

  # This is a bit meta and very hacky but I want the spell file to be writeable.
  xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/nvim/spell/en.utf-8.add";
}
