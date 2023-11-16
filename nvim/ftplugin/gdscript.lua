-- Language specific bindings for GDScript.

vim.opt_local.foldmethod = "expr"
vim.opt_local.tabstop = 4

require("which-key").register({
    name = "+GDScript",
    ["r"] = { "<cmd>GodotRun<cr>", "Run default scene" },
    ["l"] = { "<cmd>GodotRunLast<cr>", "Run last-ran scene" },
    ["c"] = { "<cmd>GodotRunCurrent<cr>", "Run current scene" },
    ["f"] = { "<cmd>GodotRunFZF<cr>", "Find scene to run with FZF" },
}, { prefix = "<localleader>", buffer = 0 })
