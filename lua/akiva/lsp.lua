local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = { 'compile_commands.json', '.git' },
    capabilities = capabilities,
})

vim.lsp.enable('clangd')
