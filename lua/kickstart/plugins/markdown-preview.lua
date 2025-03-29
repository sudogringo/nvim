return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    -- opt = {
    --   mkdp_browser = 'firefox',
    -- },
    config = function()
      vim.g.mkdp_browser = 'firefox'
      vim.g.mkdp_port = '8888'
      vim.g.mkdp_markdown_engine = 'marked'
      -- vim.g.mkdp_auto_start = 1
      vim.g.mkdp_auto_close = 1
    end,
    -- function OpenMarkdownPreview (url)
    --   execute "silent ! firefox --new-window " . a:url
    -- endfunction
    -- let g:mkdp_browserfunc = 'OpenMarkdownPreview'
  },
}
