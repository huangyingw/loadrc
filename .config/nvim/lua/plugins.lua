-- plugins.lua
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'    -- Packer can manage itself
    use 'neovim/nvim-lspconfig'     -- Collection of configurations for built-in LSP client
    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })
    use('folke/which-key.nvim')
    use({
        'huggingface/llm.nvim',
        config = function()
            local llm = require('llm')
            llm.setup({
                model = "Phind/Phind-CodeLlama-34B-v2",  -- 指定模型
                -- 其他配置选项
            })
        end
    })
end)
