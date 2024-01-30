-- init.lua
vim.cmd 'set runtimepath^=~/.vim runtimepath+=~/.vim/after'
vim.cmd 'let &packpath = &runtimepath'

-- 禁用终端的 GUI 颜色支持
vim.o.termguicolors = false

vim.cmd('colorscheme vim')

vim.cmd 'source ~/.vimrc'
require('plugins')
-- require('secret_config')

require("chatgpt").setup()

local chatgpt = require("chatgpt")
local wk = require("which-key")

wk.register({
    p = {
        name = "ChatGPT",
        e = {
            function()
                chatgpt.edit_with_instructions()
            end,
            "Edit with instructions",
        },
    },
}, {
    prefix = "<leader>",
    mode = "v",
})
