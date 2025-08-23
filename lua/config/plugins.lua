vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-tree/nvim-tree.lua" },
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "master",
    },

    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    -- { src = "https://github.com/mason-org/mason-registry" },
    -- { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    -- { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },


    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },

    { src = "https://github.com/Saghen/blink.cmp",               version = "v1.6.0" }, -- Completion engine
    { src = "https://github.com/lewis6991/gitsigns.nvim" },              -- Git integration
    { src = "https://github.com/nvim-lualine/lualine.nvim" },            -- Status line

    -- { src = "https://github.com/numToStr/Comment.nvim" }, -- Commenting
})

require 'plugins.fzf-lua'
require 'plugins.nvim-treesitter'
require 'plugins.nvim-dap'
require 'plugins.blink'

require("nvim-tree").setup()
