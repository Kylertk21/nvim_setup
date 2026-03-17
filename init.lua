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

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fo', function()
    telescope_builtin.find_files({ cwd = vim.fn.expand('%:p:h')}) -- % file :p path :h head
end, { desc= "Telescope current pane's dir" })
vim.keymap.set('n', '<leader>fg', function()
    telescope_builtin.live_grep({ cwd = vim.fn.expand('%:p:h')})
end, { desc = "Live grep in current pane's dir"})



vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump() -- This is the magic line for parameters
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
})

