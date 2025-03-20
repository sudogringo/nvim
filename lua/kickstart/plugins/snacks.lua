return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      animate = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
██╗   ██╗ █████╗ ███╗   ██╗██╗  ██╗███████╗███████╗
╚██╗ ██╔╝██╔══██╗████╗  ██║██║ ██╔╝██╔════╝██╔════╝
 ╚████╔╝ ███████║██╔██╗ ██║█████╔╝ █████╗  █████╗  
  ╚██╔╝  ██╔══██║██║╚██╗██║██╔═██╗ ██╔══╝  ██╔══╝  
   ██║   ██║  ██║██║ ╚████║██║  ██╗███████╗███████╗
   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚══════╝]],
        },
      },
      explorer = { enabled = false },
      gitbrowse = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      terminal = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
    },
    keys = {
      {
        '<leader>nC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>nn',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<leader>t',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
    },
  },
}
