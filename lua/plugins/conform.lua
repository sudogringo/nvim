require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        -- ["_"] = { "prettier" },
        format_on_save = {
            lsp_format = "fallback",
            timeout_ms = 500,
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })
})
