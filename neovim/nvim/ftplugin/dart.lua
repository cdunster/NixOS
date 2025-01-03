-- Language specific bindings for Dart (the language used by Flutter).

require("which-key").add({
    buffer = 0,
    { "<localleader>",              group = "+Dart/Flutter" },
    { "<localleader><localleader>", require('telescope').extensions.flutter.commands, desc = "List Flutter commands" },
    { "<localleader>r",             "<cmd>FlutterRun<cr>",                            desc = "Run Flutter app" },
    { "<localleader>R",             "<cmd>FlutterRestart<cr>",                        desc = "Restart the running Flutter app" },
    { "<localleader>q",             "<cmd>FlutterQuit<cr>",                           desc = "Quit the running Flutter app" },
})
