-- lsp
--------------------------------------------------------------------------------
-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
--
-- vim.lsp.enable('lua_ls')

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
    ensure_installed = {
        "lua_ls",
        "stylua",
        "pyright",
        "html",
    }
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require'
                },
                disable = { 'missing-fields' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
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
            local map = function(keys, func, desc, mode)
                mode = mode or 'n'
                vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
            end
            map('gd', function() require('fzf-lua').lsp_definitions() end, '[G]oto [D]efinition')
            map('gr', function() require('fzf-lua').lsp_references() end, '[G]oto [R]eferences')
            map('gI', function() require('fzf-lua').lsp_implementations() end, '[G]oto [I]mplementation')
            map('<leader>D', function() require('fzf-lua').lsp_typedefs() end, 'Type [D]efinition')
            map('<leader>ds', function() require('fzf-lua').lsp_document_symbols() end, '[D]ocument [S]ymbols')
            map('<leader>ws', function() require('fzf-lua').lsp_workspace_symbols() end, '[W]orkspace [S]ymbols')
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            map('<leader>ca', function() require('fzf-lua').lsp_code_action() end, '[C]ode [A]ction', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
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
