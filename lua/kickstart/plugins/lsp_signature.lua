return {
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      max_height = 12, -- max height of signature floating_window
      floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
      transparency = 50, -- disabled by default, allow floating win transparent value 1~100
      handler_opts = {
        border = 'rounded',
      },
    },
    -- or use config
    -- config = function(_, opts) require'lsp_signature'.setup({you options}) end
  },
}
