# Manage user accounts with home-manager.
{ pkgs, ... }: {
  imports = [ ./dconf.nix ];

  home.packages = with pkgs; [
    gnomeExtensions.material-shell
    dconf2nix
    fd
    ripgrep
    neovim-qt
    brave
    spotify
  ];

  programs.kitty = {
    enable = true;
    theme = "Darkside";
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      lg = "lazygit";
      ll = "exa -lah";
    };
    shellInit = ''
      set -g fish_greeting ""
    '';
  };

  programs.starship.enable = true;

  programs.git = {
    enable = true;
    userName = "Callum Dunster";
    extraConfig = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
      "includeIf \"gitdir:~/repos/work/\"".path = "~/repos/work/.gitconfig";
      "includeIf \"gitdir:~/repos/personal/\"".path = "~/repos/personal/.gitconfig";
    };
  };

  home.file."repos/work/.gitconfig".text = ''
    [user]
        email = "callum.dunster@evbox.com";
  '';

  home.file."repos/personal/.gitconfig".text = ''
    [user]
        email = "cdunster@users.noreply.github.com";
  '';

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      gui = {
        showCommandLog = false;
      };
    };
  };

  programs.bat.enable = true;

  programs.exa.enable = true;

  programs.fzf.enable = true;

  programs.neovim = {
    enable = true;
    extraConfig = ''
      " Show relative linenumbers when focused.
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
    '';
  };

  programs.direnv.enable = true;
}
