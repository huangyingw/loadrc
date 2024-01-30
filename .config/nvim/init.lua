-- init.lua
vim.cmd 'set runtimepath^=~/.vim runtimepath+=~/.vim/after'
vim.cmd 'let &packpath = &runtimepath'

-- 禁用终端的 GUI 颜色支持
vim.o.termguicolors = false

-- 设置当应用特定颜色方案时改变状态行的颜色
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "vim",
    command = "hi StatusLine ctermbg=blue ctermfg=yellow cterm=NONE"
})

-- 设置当前的颜色方案为 'vim'
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
