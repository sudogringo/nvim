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
}
require('fzf-lua').register_ui_select()
