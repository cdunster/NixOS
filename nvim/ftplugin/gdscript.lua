-- Language specific bindings for GDScript.

vim.opt_local.tabstop = 4

require("which-key").add({
    buffer = 0,
    { "<localleader>",  group = "+GDScript" },
    { "<localleader>r", "<cmd>GodotRun<cr>",        desc = "Run default scene" },
    { "<localleader>l", "<cmd>GodotRunLast<cr>",    desc = "Run last-ran scene" },
    { "<localleader>c", "<cmd>GodotRunCurrent<cr>", desc = "Run current scene" },
    { "<localleader>f", "<cmd>GodotRunFZF<cr>",     desc = "Find scene to run with FZF" },
})
