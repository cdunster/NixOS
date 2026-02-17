{ inputs, pkgs, lib, config, ... }: {
  options.hostOptions.neovim = with lib; {
    enable = mkEnableOption "Enable support Neovim";
  };

  config =
    let
      cfg = config.hostOptions.neovim;
      user = config.hostOptions.user;
    in
    lib.mkIf cfg.enable {
      # Add the overlay to install the latest version of neorg
      nixpkgs.overlays = [ inputs.neorg-overlay.overlays.default ];

      # Enable neovim and set as default editor.
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };

      # Configure neovim via home-manager
      home-manager.users.${user} = { config, ... }: {
        programs.neovim = {
          enable = true;
          defaultEditor = true;
          extraPackages = with pkgs;[
            # LSPs
            clang-tools # C/C++
            pyright # Python
            lua-language-server # Lua
            vscode-langservers-extracted # HTML/CSS/JSON/ESLint
            typescript-language-server # TypeScript and JavaScript
            svelte-language-server # Svelte (JS framework)
            tailwindcss-language-server # Tailwind CSS framework
            rust-analyzer # Rust
            nixd # Nix
            gopls # GoLang

            # DAPs Debuggers
            lldb # The debugger for the LLVM Project (lldb-dap)
            llvm # Compiler tools for the LLVM Project (llvm-symbolizer)
          ];
          initLua = ''
            require('config.custom_bindings')
            require('config.settings')
          '';
          plugins =
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
            with pkgs.vimPlugins; [
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
                      layout = { spacing = 5 },
                  }'';
              }

              # Treesitter
              {
                plugin = nvim-treesitter.withAllGrammars;
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
              flutter-tools-nvim # Advanced LSP features for Flutter

              # Display LSP progress in bottom right.
              {
                plugin = fidget-nvim;
                type = "lua";
                config = "require('fidget').setup()";
              }

              # Debug applications via the Debug Adaptor Protocol.
              {
                plugin = nvim-dap;
                type = "lua";
                config = "require('plugins.dap').config()";
              }
              nvim-nio
              nvim-dap-ui

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

              # Edit filesystem in a buffer.
              {
                plugin = oil-nvim;
                type = "lua";
                config = "require('oil').setup()";
              }

              # orgmode-like note taking in Neovim.
              {
                plugin = neorg;
                type = "lua";
                config = "require('plugins.neorg').config()";
              }
              neorg-telescope

              # Task runner and job manager.
              {
                plugin = overseer-nvim;
                type = "lua";
                config = "require('plugins.overseer').config()";
              }
            ];
        };

        xdg.configFile."nvim/lua/plugins".source = ./nvim/lua/plugins;
        xdg.configFile."nvim/lua/config".source = ./nvim/lua/config;
        xdg.configFile."nvim/lua/overseer".source = ./nvim/lua/overseer;
        xdg.configFile."nvim/ftplugin".source = ./nvim/ftplugin;

        # This is a bit meta and very hacky but I want the spell file to be writeable.
        xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/neovim/nvim/spell/en.utf-8.add";
      };
    };
}
