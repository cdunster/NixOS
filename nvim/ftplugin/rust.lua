-- Language specific bindings for Rust.

require("which-key").register({
    name = "+Rust lang",
    ["r"] = { function() vim.cmd.RustLsp('runnables') end, "List Rust runnables" },
    ["d"] = { function() vim.cmd.RustLsp('debuggables') end, "List Rust debuggables" },
    ["e"] = { function() vim.cmd.RustLsp('expandMacro') end, "Recursively expand macro" },
    ["o"] = { function() vim.cmd.RustLsp('openCargo') end, "Open Cargo.toml" },
    ["J"] = { function() vim.cmd.RustLsp('joinLines') end, "Join lines" },
}, { prefix = "<localleader>", buffer = 0 })
