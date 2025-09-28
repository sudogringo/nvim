require("fzf-lua").setup({
    { 'ivy' },
    files = {
        cmd = 'fd --type f --exclude "*.class, .git/*"',
    },
    buffers = {
        previewer = false, -- Disable preview for buffers
    },
    file_ignore_patterns = {
        "node_modules",
        ".git",
        "%.class",
        ".next/",
        "%.lockb",
        "%.png",
        "%.jpg",
        "%.webp",
        "%.gif",
        "%-lock.json",
        "%-lock.yaml",
    },
})
require("fzf-lua").register_ui_select()
