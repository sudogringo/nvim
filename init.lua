--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

]]
--

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- Base URL for the spell files
local spellfile_URL = 'https://ftp.nluug.nl/vim/runtime/spell'

-- Function to download the spell file
function Download_spell_file(lang)
  -- Construct the full URL for the spell file
  local file_url = spellfile_URL .. '/' .. lang .. '.utf-8.spl'
  local dest_path = vim.fn.stdpath 'config' .. '/spell/' .. lang .. '.utf-8.spl'

  -- Create the spell directory if it doesn't exist
  vim.fn.mkdir(vim.fn.stdpath 'config' .. '/spell', 'p')

  -- Download the file using curl (make sure curl is installed on your system)
  os.execute('curl -o ' .. dest_path .. ' ' .. file_url)

  -- Notify the user
  print('Downloaded spell file for: ' .. lang)

  -- Set the spell file for the current buffer
  vim.opt_local.spelllang = lang
end

-- Create the autocommand
vim.api.nvim_create_autocmd('SpellFileMissing', {
  pattern = '*',
  callback = function()
    local lang = vim.fn.expand '<amatch>'
    Download_spell_file(lang)
  end,
})

function SetRandomColorscheme()
  vim.cmd 'colorscheme randomhue'
  -- may change in future to all installed themes.
end

-- Set a random colorscheme on startup
vim.api.nvim_create_autocmd('VimEnter', {
  callback = SetRandomColorscheme,
})
-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
