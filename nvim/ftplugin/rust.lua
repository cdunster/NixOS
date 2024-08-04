-- Language specific bindings for Rust.

require("which-key").add({
    buffer = 0,
    { "<localleader>",  group = "+Rust lang" },
    { "<localleader>r", function() vim.cmd.RustLsp('runnables') end,   desc = "List Rust runnables" },
    { "<localleader>d", function() vim.cmd.RustLsp('debuggables') end, desc = "List Rust debuggables" },
    { "<localleader>e", function() vim.cmd.RustLsp('expandMacro') end, desc = "Recursively expand macro" },
    { "<localleader>o", function() vim.cmd.RustLsp('openCargo') end,   desc = "Open Cargo.toml" },
    { "<localleader>J", function() vim.cmd.RustLsp('joinLines') end,   desc = "Join lines" },
})
