require("fzf-lua").setup({
    { 'ivy' },
    files = {
        -- cmd = 'fd --type f --exclude "*.class"',
    },
    buffers = {
        previewer = false, -- Disable preview for buffers
    },
})
require("fzf-lua").register_ui_select()
