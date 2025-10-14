require "nvchad.mappings"

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Window split mappings
map("n", "<leader>sh", ":split<CR>", opts)
map("n", "<leader>sv", ":vsplit<CR>", opts)
