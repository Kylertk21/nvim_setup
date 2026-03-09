require("akiva")


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"    -- prevents layout shifting from LSP signs
vim.opt.updatetime = 250      -- faster LSP hover/diagnostics
vim.keymap.set("n", "<leader>cc", ":!gcc % -o %:r && ./%:r<CR>")
vim.keymap.set("n", "<leader>cm", ":!make<CR>")
vim.keymap.set("n", "<leader>r2", function()
    vim.cmd("vsplit | terminal r2 " .. vim.fn.expand("%:r"))
end)
