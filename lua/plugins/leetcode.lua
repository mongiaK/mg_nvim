return {
    {
        "Dhanus3133/LeetBuddy.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require('leetbuddy').setup({
                domain = "cn", -- `cn` for chinese leetcode
                language = "cpp",
            })
        end,
        keys = {
            { "<leader>cQ", "<cmd>LBQuestions<cr>", desc = "leetcode List Questions" },
            { "<leader>cL", "<cmd>LBQuestion<cr>",  desc = "leetcode View Question" },
            { "<leader>cR", "<cmd>LBReset<cr>",     desc = "leetcode Reset Code" },
            { "<leader>cT", "<cmd>LBTest<cr>",      desc = "leetcode Run Code" },
            { "<leader>cS", "<cmd>LBSubmit<cr>",    desc = "leetcode Submit Code" },
        },
    }
}
