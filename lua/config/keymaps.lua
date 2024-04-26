-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local _M = {}

function _M.SymbolsOutlineKeyMaps()
    return {
        { "<leader>S", "<cmd>SymbolsOutline<cr>", desc = "SymbolsOutline" },
    }
end

function _M.LeetBuddyKeyMaps()
    return {
        { "<leader>cQ", "<cmd>LBQuestions<cr>", desc = "leetcode List Questions" },
        { "<leader>cL", "<cmd>LBQuestion<cr>",  desc = "leetcode View Question" },
        { "<leader>cR", "<cmd>LBReset<cr>",     desc = "leetcode Reset Code" },
        { "<leader>cT", "<cmd>LBTest<cr>",      desc = "leetcode Run Code" },
        { "<leader>cS", "<cmd>LBSubmit<cr>",    desc = "leetcode Submit Code" },
    }
end

function _M.BasicKeyMaps()
    vim.keymap.set("n", "<S-h>", "<cmd>echo<cr>", { desc = "hello world demo" })
end

return _M
