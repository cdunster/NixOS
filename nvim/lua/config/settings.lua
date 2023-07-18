vim.cmd [[
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
      set nospell                 "Disable built-in spell-checking (replaced by spelunker).
      set spelllang=en_gb         "Set language to proper English.
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
]]
