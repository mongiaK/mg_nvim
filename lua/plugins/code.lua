return {
    { "folke/trouble.nvim", enabled = true },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "codelldb",
                "shfmt",
                "delve",
                "clangd",
                "debugpy",
            },
        },
    },
    {
        "ludovicchabant/vim-gutentags",
        enabled = true,
    },
    {
        -- 窗口右侧显示函数，全局变量
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy",
        config = function()
            require("symbols-outline").setup({
                relative_width = false,
                width = 30,
            })
        end
    },

    {
        "neovim/nvim-lspconfig",
        opts = {
            setup = {
                clangd = function(_, opts)
                    opts.capabilities.offsetEncoding = { "utf-16" }
                end,
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        enable = true,
        opts = {
            sources = {
                require("null-ls").builtins.formatting.clang_format.with({
                    filetypes = { "c", "cpp", "hpp", "cc" },
                    extra_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" },
                }),
            },
        },
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            local Config = require("lazyvim.config")
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            for name, sign in pairs(Config.icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end

            local dap = require("dap")
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    -- CHANGE THIS to your path!
                    command = "codelldb",
                    args = { "--port", "${port}" },

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                },
            }
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = function()
                        local input = vim.fn.input("Input args: ")
                        return vim.fn.split(input, " ", true)
                    end,

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
                    runInTerminal = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            dap.adapters.go = function(callback)
                local stdout = vim.loop.new_pipe(false)
                local handle
                local pid_or_err
                local port = 38697
                local opts = {
                    stdio = { nil, stdout },
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true,
                }
                handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
                    stdout:close()
                    handle:close()
                    if code ~= 0 then
                        vim.notify(
                            string.format(
                                '"dlv" exited with code: %d, please check your configs for correctness.',
                                code
                            ),
                            vim.log.levels.WARN,
                            { title = "[go] DAP Warning!" }
                        )
                    end
                end)
                assert(handle, "Error running dlv: " .. tostring(pid_or_err))
                stdout:read_start(function(err, chunk)
                    assert(not err, err)
                    if chunk then
                        vim.schedule(function()
                            require("dap.repl").append(chunk)
                        end)
                    end
                end)
                -- Wait for delve to start

                vim.defer_fn(function()
                    callback({ type = "server", host = "127.0.0.1", port = port })
                end, 100)
            end
            -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
            dap.configurations.go = {
                { type = "go", name = "Debug", request = "launch", program = "${file}" },
                {
                    type = "go",
                    name = "Debug with args",
                    request = "launch",
                    program = "${file}",
                    args = function()
                        local argument_string = vim.fn.input("Program arg(s): ")
                        return vim.fn.split(argument_string, " ", true)
                    end,
                },
                {
                    type = "go",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                }, -- works with go.mod packages and sub packages
                {
                    type = "go",
                    name = "Debug test (go.mod)",
                    request = "launch",
                    mode = "test",
                    program = "./${relativeFileDirname}",
                },
            }

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
    }
}
