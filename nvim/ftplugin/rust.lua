-- Language specific bindings for Rust.

require("which-key").register({
    name = "+Rust lang",
    ["r"] = { "<cmd>lua require('rust-tools.runnables').runnables()<cr>", "List Rust runnables" },
    ["d"] = { "<cmd>lua require('rust-tools.debuggables').debuggables()<cr>", "List Rust debuggables" },
    ["e"] = { "<cmd>lua require('rust-tools.expand_macro').expand_macro()<cr>", "Recursively expand macro" },
    ["o"] = { "<cmd>lua require('rust-tools.open_cargo_toml').open_cargo_toml()<cr>", "Open Cargo.toml" },
    ["J"] = { "<cmd>lua require('rust-tools.join_lines').join_lines()<cr>", "Join lines" },
}, { prefix = "<localleader>", buffer = 0 })
