require "nvchad.mappings"

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Jump List
map("n", "gb", "<C-o>", { desc = "Go back in jump list" })

-- Window split mappings
map("n", "<leader>sh", ":split<CR>", opts)
map("n", "<leader>sv", ":vsplit<CR>", opts)

-- DAP mappings
local dap = require('dap')
local dapui = require('dapui')

map('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
map('n', '<leader>dsi', dap.step_into, { desc = 'Debug: Step Into' })
map('n', '<leader>dso', dap.step_over, { desc = 'Debug: Step Over' })
map('n', '<leader>dse', dap.step_out, { desc = 'Debug: Step Out' })

map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
map('n', '<leader>du', dapui.toggle, { desc = 'Debug: Open Debugging UI' })

-- CodeCompanion Mappings
map({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat Toggle" })

map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })

map("v", "<leader>ce", "<cmd>CodeCompanion<cr>", { desc = "AI Inline Edit" })

map("v", "<leader>cx", "<cmd>CodeCompanionChat Add<cr>", { desc = "AI Chat Add Selection" })
