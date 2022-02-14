{ vim-startify }: {
  plugin = vim-startify;
  config = ''
  "Automatically update sessions before quitting or loading a new session.
  let g:startify_session_persistence = 1

  "When opening a file or bookmark, change to the root directory.
  let g:startify_change_to_vcs_root = 1

  "Set header to Unicode instead of ASCII.
  let g:startify_fortune_use_unicode = 1

  "Do not show empty buffer or quit links on the welcome page.
  let g:startify_enable_special = 0

  "Sort the session list by recently used instead of alphabetically.
  let g:startify_session_sort = 1

  "Define the categories on the startify page.
  let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions']},
  \ { 'type': 'commands',  'header': ['   Commands']},
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']},
  \ { 'type': 'files',     'header': ['   Recent Files']},
  \ { 'type': 'dir',       'header': ['   Files in '. getcwd()]},
  \]

  "Add custom commands when on startify page.
  let g:startify_commands = [
  \ { 'g': ['G5+', 'SLoad G5+']},
  \ { 'r': ['RACE', 'SLoad RACE']},
  \ { 'w': ['Vimwiki', 'VimwikiIndex']},
  \]
  '';
}
