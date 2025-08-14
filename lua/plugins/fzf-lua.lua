require("fzf-lua").setup {
    { "ivy" }
}

local fzf = require('fzf-lua')

vim.keymap.set('n', '<leader>q', fzf.diagnostics_document, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf-lua' })
vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

-- Fuzzily search in current buffer (dropdown style)
vim.keymap.set('n', '<leader>/', function()
  fzf.blines({ previewer = false })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Live grep in open files
vim.keymap.set('n', '<leader>s/', function()
  fzf.live_grep({ cmd = "rg --files -g '!.git' | grep -e '^" .. vim.fn.expand('%:p:h') .. "'" })
end, { desc = '[S]earch [/] in Open Files' })

-- Search Neovim config files
vim.keymap.set('n', '<leader>sn', function()
  fzf.files({ cwd = vim.fn.stdpath('config') })
end, { desc = '[S]earch [N]eovim files' })

