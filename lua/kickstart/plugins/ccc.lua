return {
  {
    'uga-rosa/ccc.nvim',
    -- #FFFFFF
    config = function()
      require('ccc').setup {
        -- Your configuration options here
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      }
    end,
    opts = {
      lazy = false,
      vim.api.nvim_set_keymap('n', '<leader>cp', '<cmd>CccPick<cr>', { noremap = true, silent = true }),
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
