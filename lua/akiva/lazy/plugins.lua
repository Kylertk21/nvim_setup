return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
    vim.lsp.enable("clangd")
  end,

{ "hrsh7th/nvim-cmp" },
{ "hrsh7th/cmp-nvim-lsp" },
{ "hrsh7th/cmp-buffer" },
{ "L3MON4D3/LuaSnip" },        -- snippets engine
{ "saadparwaiz1/cmp_luasnip" },

{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "c", "cpp", "make", "cmake" },
      highlight = { enable = true },
    })
  end,
},

{
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = { c = { "clang_format" } },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    })
  end,
},

{
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },  -- grep across project
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
  },
},

{
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup()
  end,
  keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>" } },
},

{
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }
    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
    }
  end,
},

-- UI for dap (highly recommended, otherwise it's very bare)
{
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    -- auto open/close UI when debugging starts/ends
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  end,
},
{"windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
},
{"yorickpeterse/nvim-window",
    keys = {
        { "<leader>wj", "<cmd> lua require('nvim-window').pick()<cr>",
            desc = "nvim-window: Jump to window" }
    },
    config = true;
}

    }
