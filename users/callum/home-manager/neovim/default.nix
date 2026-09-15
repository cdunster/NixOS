{ pkgs, config, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;
    extraPackages = with pkgs;[
      # LSPs
      clang-tools # C/C++
      pyright # Python
      lua-language-server # Lua
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint
      typescript-language-server # TypeScript and JavaScript
      biome # TypeScript formatting and linting
      svelte-language-server # Svelte (JS framework)
      tailwindcss-language-server # Tailwind CSS framework
      rust-analyzer # Rust
      nixd # Nix
      gopls # GoLang
      tinymist # Typst

      # DAPs Debuggers
      lldb # The debugger for the LLVM Project (lldb-dap)
      llvm # Compiler tools for the LLVM Project (llvm-symbolizer)
    ];
    initLua = ''
      require('config.custom_bindings')
      require('config.settings')

      -- Apply stylix colourscheme based on the current dark mode
      vim.schedule(function() require('config.recolour').apply() end)
    '';
    plugins =
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

        # Edit filesystem in a buffer.
        {
          plugin = oil-nvim;
          type = "lua";
          config = "require('oil').setup()";
        }

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
  xdg.configFile."nvim/colors".source = ./nvim/colors;

  # The current Stylix palette, regenerated on every rebuild so it switches
  # with the "dark" specialisation
  xdg.configFile."nvim/lua/stylix_palette.lua".text = ''
    return {
      base00 = '#${config.lib.stylix.colors.base00}',
      base01 = '#${config.lib.stylix.colors.base01}',
      base02 = '#${config.lib.stylix.colors.base02}',
      base03 = '#${config.lib.stylix.colors.base03}',
      base04 = '#${config.lib.stylix.colors.base04}',
      base05 = '#${config.lib.stylix.colors.base05}',
      base06 = '#${config.lib.stylix.colors.base06}',
      base07 = '#${config.lib.stylix.colors.base07}',
      base08 = '#${config.lib.stylix.colors.base08}',
      base09 = '#${config.lib.stylix.colors.base09}',
      base0A = '#${config.lib.stylix.colors.base0A}',
      base0B = '#${config.lib.stylix.colors.base0B}',
      base0C = '#${config.lib.stylix.colors.base0C}',
      base0D = '#${config.lib.stylix.colors.base0D}',
      base0E = '#${config.lib.stylix.colors.base0E}',
      base0F = '#${config.lib.stylix.colors.base0F}',
    }
  '';

  # This is a bit meta and very hacky but I want the spell file to be writeable.
  xdg.configFile."nvim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/users/callum/home-manager/neovim/nvim/spell/en.utf-8.add";
}
