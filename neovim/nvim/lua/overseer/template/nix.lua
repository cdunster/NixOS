local constants = require("overseer.constants")
local log = require("overseer.log")
local TAG = constants.TAG

local function add_nix_item(ret, sub_cmd, package_name, cwd)
    local name = string.format("nix %s", sub_cmd)
    local args = nil

    if package_name then
        local flake = string.format(".#%s", package_name)
        name = name .. flake
        args = { flake }
    end

    local tags = {}
    if sub_cmd == "run" then
        tags = { TAG.RUN }
    else
        tags = { TAG.BUILD }
    end

    table.insert(
        ret, {
            name = name,
            priority = 40,
            tags = tags,
            builder = function(_)
                return {
                    cmd = { "nix", sub_cmd },
                    args = args,
                    cwd = cwd,
                }
            end,
        }
    )
end

local function add_nix_items(ret, sub_cmd, items, cwd)
    if items.default then
        add_nix_item(ret, sub_cmd, nil, cwd)
    end

    for item, _ in pairs(items) do
        add_nix_item(ret, sub_cmd, item, cwd)
    end
end

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

                    if not json then
                        break;
                    end

                    if json.packages then
                        local packages = json.packages[system] or {}
                        add_nix_items(ret, "build", packages, cwd)
                    end

                    if json.apps then
                        local apps = json.apps[system] or {}
                        add_nix_items(ret, "run", apps, cwd)
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

        local ret = {}
        parse_nix_flake_output(cwd, ret, cb)
    end,
}
return provider
