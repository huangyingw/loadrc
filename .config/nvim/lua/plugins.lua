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
end)
