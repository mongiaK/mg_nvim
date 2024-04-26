local _M = {}

function _M.config()
    local dap = require("dap")
    local function isempty(s)
        return s == nil or s == ""
    end
    dap.adapters.python = function(cb, config)
        if config.request == "attach" then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port or 8080
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or "127.0.0.1"
            cb({
                type = "server",
                port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                host = host,
                options = {
                    source_filetype = "python",
                },
            })
        else
            cb({
                type = "executable",
                command = '/usr/bin/python3',
                -- command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
                args = { "-m", "debugpy.adapter" },
                options = {
                    source_filetype = "python",
                },
            })
        end
    end
    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = "launch",
            name = "Launch file",
            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
                if not isempty(vim.env.CONDA_PREFIX) then
                    return vim.env.CONDA_PREFIX .. "/bin/python"
                else
                    return "/usr/bin/python3"
                end
            end,
        },
    }
end

return _M
