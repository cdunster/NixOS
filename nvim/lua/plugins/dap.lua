local M = {}

M.config = function()
    local dap = require('dap')

    -- lldb for Rust, C, and C++
    dap.adapters.lldb = {
        type = 'executable',
        command = '/etc/profiles/per-user/callum/bin/lldb-dap',
        name = 'lldb'
    }

    dap.configurations.rust = {
        {
            name = 'Launch',
            type = 'lldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
            initCommands = function()
                -- Find out where to look for the pretty printer Python module
                local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

                local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
                local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                local commands = {}
                local file = io.open(commands_file, 'r')
                if file then
                    for line in file:lines() do
                        table.insert(commands, line)
                    end
                    file:close()
                end
                table.insert(commands, 1, script_import)

                return commands
            end,

            -- 💀
            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
        },
    }

    require('dapui').setup()

    local dapui = require('dapui')
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    require('which-key').add({
        { '<F5>',   require('dap').continue,          desc = 'Start/Continue debugging' },
        { '<S-F5>', require('dap').continue,          desc = 'Stop debugging' },
        { '<F9>',   require('dap').toggle_breakpoint, desc = 'Toggle breakpoint' },
        { '<F10>',  require('dap').step_over,         desc = 'Step over' },
        { '<F11>',  require('dap').step_into,         desc = 'Step into' },
    })
end

return M
