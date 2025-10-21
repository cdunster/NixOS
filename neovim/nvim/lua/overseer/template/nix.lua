local constants = require("overseer.constants")
local log = require("overseer.log")
local overseer = require("overseer")
local TAG = constants.TAG

---@type overseer.TemplateFileDefinition
local tmpl = {
    name = "nix build",
    priority = 40,
    tags = { TAG.BUILD },
    params = {
        args = { optional = true, type = "list", delimiter = " " },
        cwd = { optional = true },
    },
    builder = function(params)
        return {
            cmd = { "nix", "build" },
            args = params.args,
            cwd = params.cwd,
        }
    end,
}

local function parse_nix_flake_output(cwd, ret, cb)
    local job_id = vim.fn.jobstart({ "nix", "flake", "show", "--json" }, {
        cwd = cwd,
        stdout_buffered = true,
        env = {
            ["LANG"] = "C.UTF-8",
        },
        on_stdout = vim.schedule_wrap(function(_, output)
            local system = vim.system({ "nix", "config", "show", "system" }):wait().stdout:gsub("%s+", "")

            for _, line in ipairs(output) do
                if line ~= '' then
                    local json = vim.json.decode(line)

                    if not json or not json.packages then
                        break;
                    end

                    local packages = json.packages[system] or {}

                    for package_name, _ in pairs(packages) do
                        local flake = string.format(".#%s", package_name)
                        local name = string.format("nix build %s", flake)
                        local args = { flake }
                        table.insert(
                            ret,
                            overseer.wrap_template(tmpl, { name = name }, { args = args, cwd = cwd })
                        )
                    end
                end
            end

            cb(ret)
        end),
    })
    if job_id == 0 then
        log:error("Passed invalid arguments to 'nix flake show'")
        cb(ret)
    elseif job_id == -1 then
        log:error("'nix flake show' is not executable")
        cb(ret)
    end
end

---@param opts overseer.SearchParams
---@return nil|string
local function get_flake_file(opts)
    return vim.fs.find("flake.nix", { upward = true, type = "file", path = opts.dir })[1]
end

---@type overseer.TemplateFileProvider
local provider = {
    cache_key = function(opts)
        return get_flake_file(opts)
    end,
    condition = {
        callback = function(opts)
            if vim.fn.executable("nix") == 0 then
                return false, 'Command "nix" not found'
            end
            if not get_flake_file(opts) then
                return false, "No flake.nix found"
            end
            return true
        end,
    },
    generator = function(opts, cb)
        local flake_file = assert(get_flake_file(opts))
        local cwd = vim.fs.dirname(flake_file)

        local ret = { overseer.wrap_template(tmpl, nil, { cwd = cwd }) }
        parse_nix_flake_output(cwd, ret, cb)
    end,
}
return provider
