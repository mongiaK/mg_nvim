local keymaps = require("config.keymaps")
local gutentags_config = require("plugin_config.gutentags")
local mason_config = require("plugin_config.mason")
local symbols_outline_config = require("plugin_config.symbols_outline")
local lspconfig_config = require("plugin_config.lspconfig")
local null_ls_config = require("plugin_config.null_ls")

return {
    -- 显示lsp的诊断信息
    { "folke/trouble.nvim", enabled = true },
    -- chatgpt插件 编码使用
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
    },
    -- 管理lsp，dap 等安装
    {
        "williamboman/mason.nvim",
        opts = mason_config.option()
    },
    -- 自动生成tag文件
    {
        "ludovicchabant/vim-gutentags",
        enabled = true,
        config = gutentags_config.config
    },
    -- 窗口右侧显示函数，全局变量
    {
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy",
        config = symbols_outline_config.config,
        keys = keymaps.SymbolsOutlineKeyMaps()
    },
    -- 配置lsp的配置，不同语言单独配置
    {
        "neovim/nvim-lspconfig",
        opts = lspconfig_config.option()
    },
    -- 格式化代码
    {
        "jose-elias-alvarez/null-ls.nvim",
        enable = true,
        opts = null_ls_config.option()
    },
    -- golang的插件，自动跳转
    {
        "crispgm/nvim-go",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "rcarriga/nvim-notify",
            "neovim/nvim-lspconfig"
        }
    }
}
