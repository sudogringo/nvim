return {
  {
    'nvim-java/nvim-java',
    handlers = {
      -- By assigning an empty function, you can remove the notifications
      -- printed to the cmd
      ['$/progress'] = function(_, result, ctx) end,
    },
  },
}
