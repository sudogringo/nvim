require('fzf-lua').setup {
  winopts = {
    width = 1.0,
    height = 0.3,
    row = 1.0,
    col = 0,
    border = 'none',
    preview = {
      layout = 'flex',
      flip_columns = 120,
      horizontal = 'right:50%',
    },
  },
  fzf_opts = {
    ['--layout'] = 'reverse',
  },
  files = {
    cmd = 'fd --type f --exclude "*.class, .git/*"',
  },
  buffers = {
    previewer = false,
  },
  file_ignore_patterns = {
    'node_modules',
    '.git',
    '%.class',
    '.next/',
    '%.lockb',
    '%.png',
    '%.jpg',
    '%.webp',
    '%.gif',
    '%-lock.json',
    '%-lock.yaml',
  },
  diagnostics = {
    actions = {
      ['ctrl-y'] = function(selected, opts)
        local text = selected[1]
        vim.fn.setreg('+', text)
      end,
    },
  },
  undotree = {
    winopts = {
      width = 0.9,
      height = 0.8,
      row = 0.1,
      col = 0.5,
      border = 'single',
    },
    fzf_opts = {
      ['--no-select-1'] = '',
    },
  },
}
require('fzf-lua').register_ui_select()
