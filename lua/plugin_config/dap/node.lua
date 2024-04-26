local _M = {}

function _M.config()
    local dap = require("dap")
    --node configurations
    dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }
    dap.configurations.javascript = {
        {
            name = 'Launch',
            type = 'node2',
            request = 'launch',
            program = '${file}',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            -- For this to work you need to make sure the node process is started with the `--inspect` flag.
            name = 'Attach to process',
            type = 'node2',
            request = 'attach',
            restart = true,
            processId = require 'dap.utils'.pick_process,
        },
    }
end

return _M
