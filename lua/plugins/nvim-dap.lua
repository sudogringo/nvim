-- "mfussenegger/nvim-dap",
-- dependencies = {
--   "leoluz/nvim-dap-go",
--   "rcarriga/nvim-dap-ui",
--   "theHamsta/nvim-dap-virtual-text",
--   "nvim-neotest/nvim-nio",
--   "williamboman/mason.nvim",
-- },
local dap = require 'dap'
local dapui = require 'dapui'

require('dapui').setup()
-- require("dap-go").setup()

require('nvim-dap-virtual-text').setup {}

require('mason-nvim-dap').setup {
  -- Makes a best effort to setup the various debuggers with
  -- reasonable debug configurations
  automatic_installation = true,

  -- You can provide additional configuration to the handlers,
  -- see mason-nvim-dap README for more information
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
  },

  ensure_installed = {
    'delve',
    'debugpy',
    'delve',
    'java-debug-adapter',
    'java-test',
  },
}

dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

vim.keymap.set('n', '<space>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set('n', '<space>gb', dap.run_to_cursor, { desc = 'DAP run to cursor' })

-- Eval var under cursor
vim.keymap.set('n', '<leader>?', function()
  require('dapui').eval(nil, { enter = true })
end, { desc = 'Eval variable under cursor' })

vim.keymap.set('n', '<F1>', dap.continue, { desc = 'DAP Continue' })
vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'DAP Step Into' })
vim.keymap.set('n', '<F3>', dap.step_over, { desc = 'DAP Step Over' })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'DAP Step Out' })
vim.keymap.set('n', '<F5>', dap.step_back, { desc = 'DAP Step Back' })
vim.keymap.set('n', '<F6>', dap.restart, { desc = 'DAP Restart' })

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

dap.configurations.java = {
  {
    name = 'Debug Launch (2GB)',
    type = 'java',
    request = 'launch',
    vmArgs = '' .. '-Xmx2g ',
  },
  {
    name = 'Debug Attach (8000)',
    type = 'java',
    request = 'attach',
    hostName = '127.0.0.1',
    port = 8000,
  },
  {
    name = 'Debug Attach (5005)',
    type = 'java',
    request = 'attach',
    hostName = '127.0.0.1',
    port = 5005,
  },
  {
    name = 'My Custom Java Run Configuration',
    type = 'java',
    request = 'launch',
    -- You need to extend the classPath to list your dependencies.
    -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
    -- classPaths = {},

    -- If using multi-module projects, remove otherwise.
    -- projectName = "yourProjectName",

    -- javaExec = "java",
    -- mainClass = 'replace.with.your.fully.qualified.MainClass',

    -- If using the JDK9+ module system, this needs to be extended
    -- `nvim-jdtls` would automatically populate this property
    -- modulePaths = {},
    vmArgs = '' .. '-Xmx2g ',
  },
}
local function get_args()
  return { vim.fn.input 'Enter file path: ' }
end
-- -- Python configuration
-- dap.adapters.python = function(cb, config)
--   if config.request == 'attach' then
--     ---@diagnostic disable-next-line: undefined-field
--     local port = (config.connect or config).port
--     ---@diagnostic disable-next-line: undefined-field
--     local host = (config.connect or config).host or '127.0.0.1'
--     cb {
--       type = 'server',
--       port = assert(port, '`connect.port` is required for a python `attach` configuration'),
--       host = host,
--       options = {
--         source_filetype = 'python',
--       },
--     }
--   else
--     cb {
--       type = 'executable',
--       command = '/home/tiago/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
--       args = { '-m', 'debugpy.adapter' },
--       options = {
--         source_filetype = 'python',
--       },
--     }
--   end
-- end

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = 'Launch file',

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = '${file}', -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end,
  },

  {
    type = 'python',
    request = 'launch',
    name = 'Launch file with args',
    program = '${file}',
    args = get_args,
  },
}
