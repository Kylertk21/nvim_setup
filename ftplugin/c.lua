vim.treesitter.start()

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = false
vim.opt_local.foldlevel = 99
vim.opt_local.cindent = true
