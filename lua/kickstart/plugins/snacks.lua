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
      input = {
        icon = ' ',
        icon_hl = 'SnacksInputIcon',
        icon_pos = 'left',
        prompt_pos = 'title',
        win = { style = 'input' },
        expand = true,
      },
      lazygit = { enabled = true },
      picker = { enabled = false },
      notifier = {
        timeout = 3000, -- default timeout in ms
        width = { min = 40, max = 0.2 },
        height = { min = 1, max = 0.6 },
        -- editor margin to keep free. tabline and statusline are taken into account automatically
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true, -- add 1 cell of left/right padding to the notification window
        sort = { 'level', 'added' }, -- sort by level and time
        -- minimum log level to display. TRACE is the lowest
        -- all notifications are stored in history
        level = vim.log.levels.TRACE,
        icons = {
          error = ' ',
          warn = ' ',
          info = ' ',
          debug = ' ',
          trace = ' ',
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      terminal = { enabled = true },
      toggle = {
        which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
        notify = true, -- show a notification when toggling
        -- icons for enabled/disabled states
        icon = {
          enabled = ' ',
          disabled = ' ',
        },
        -- colors for enabled/disabled states
        color = {
          enabled = 'green',
          disabled = 'yellow',
        },
        wk_desc = {
          enabled = 'Disable ',
          disabled = 'Enable ',
        },
      },
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
