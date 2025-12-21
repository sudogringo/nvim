-- [[ Basic Keymaps ]]key
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ff", function()
  require("conform").format({
    lsp_format = "fallback",
  })
end, { desc = "Format buffer" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

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

local function setup_lsp_keymaps(bufnr)
    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    map('gd', function() require('fzf-lua').lsp_definitions() end, '[G]oto [D]efinition')
    map('gr', function() require('fzf-lua').lsp_references() end, '[G]oto [R]eferences')
    map('gI', function() require('fzf-lua').lsp_implementations() end, '[G]oto [I]mplementation')
    map('<leader>D', function() require('fzf-lua').lsp_typedefs() end, 'Type [D]efinition')
    map('<leader>ds', function() require('fzf-lua').lsp_document_symbols() end, '[D]ocument [S]ymbols')
    map('<leader>ws', function() require('fzf-lua').lsp_workspace_symbols() end, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', function() require('fzf-lua').lsp_code_actions() end, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.trigger()
    end, { buffer = bufnr })
end

vim.keymap.set("n", "<leader>-", "<cmd>NvimTreeToggle<CR>")
-- Add language spell check
vim.keymap.set('n', '<leader>dS', '<cmd>setlocal spell! spelllang=es<CR>', { desc = 'Spelling ES_UTF' })
vim.keymap.set('n', '<leader>dE', '<cmd>setlocal spell! spelllang=en_us<CR>', { desc = 'Spelling EN_US' })


-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Quick file navigation
-- vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>sf", ":find ", { desc = "Find file" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })


return {
    setup_lsp_keymaps = setup_lsp_keymaps,
}
-- vim: ts=2 sts=2 sw=2 et
