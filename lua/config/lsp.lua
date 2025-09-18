-- lsp
--------------------------------------------------------------------------------
-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
--
require('mason').setup()

-- vim.lsp.log.set_level 'trace'
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_path = home .. "/.cache/jdtls/" .. project_name
local jdtls_install_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
local lombok_path = jdtls_install_path .. '/lombok.jar'
vim.lsp.config("jdtls", {
    cmd = {
        'jdtls',
        '-data', workspace_path,
        '-javaagent:', lombok_path,
    },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),
    settings = {
        eclipse = {
            downloadSources = true,
        },
        maven = {
            downloadSources = true,
        },
        signatureHelp = { enabled = true },
        java = {
            signatureHelp = { enabled = true },
        },
        contentProvider = { preferred = "fernflower" },
        completion = {
            favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
        },

    },
})
vim.lsp.enable({
    'lua_ls',
    'ts_ls',
    'bashls',
    'jdtls',
    'pyright',
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
            require('config.keymaps').setup_lsp_keymaps(ev.buf)
        end
    end,
})

-- Diagnostics
vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true

    -- Alternatively, customize specific options
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})
