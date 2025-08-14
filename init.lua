--[[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ 
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   
         ░    ░  ░    ░ ░        ░   ░         ░   
                                ░                  
 ▄████▄   ▒█████   ███▄    █   █████▒██▓  ▄████    
▒██▀ ▀█  ▒██▒  ██▒ ██ ▀█   █ ▓██   ▒▓██▒ ██▒ ▀█▒   
▒▓█    ▄ ▒██░  ██▒▓██  ▀█ ██▒▒████ ░▒██▒▒██░▄▄▄░   
▒▓▓▄ ▄██▒▒██   ██░▓██▒  ▐▌██▒░▓█▒  ░░██░░▓█  ██▓   
▒ ▓███▀ ░░ ████▓▒░▒██░   ▓██░░▒█░   ░██░░▒▓███▀▒   
░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒ ░   ░▓   ░▒   ▒    
  ░  ▒     ░ ▒ ▒░ ░ ░░   ░ ▒░ ░      ▒ ░  ░   ░    
░        ░ ░ ░ ▒     ░   ░ ░  ░ ░    ▒ ░░ ░   ░    
░ ░          ░ ░           ░         ░        ░    
░                                                  ]]
--


require 'options'
require 'keymaps'
require 'autocmd'
require 'plugins'
require 'lsp'

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

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
-- -- The line beneath this is called `modeline`. See `:help modeline`
-- -- vim: ts=2 sts=2 sw=2 et
