local c_cpp_rust_config = require("plugin_config.dap.c_cpp_rust")
local go_config = require("plugin_config.dap.go")
local node_config = require("plugin_config.dap.node")
local python_config = require("plugin_config.dap.python")

local _M = {}

function _M.config()
    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
            "Dap" .. name,
            { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
    end

    c_cpp_rust_config.config()
    go_config.config()
    node_config.config()
    python_config.config()
end

return _M
