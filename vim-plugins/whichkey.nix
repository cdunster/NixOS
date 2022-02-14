{ which-key-nvim }: {
  plugin = which-key-nvim;
  config = ''
  lua << EOF
  require("which-key").setup {
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC", ["<space>"] = "SPC" },
      layout = { spacing = 5 },
  }
  EOF
  '';
}
