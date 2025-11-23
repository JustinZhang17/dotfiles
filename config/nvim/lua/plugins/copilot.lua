return {
  "zbirenbaum/copilot.lua",
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
      },
      panel = { enabled = true },
      filetypes = {
        vue = true,
        typescript = true,
        javascript = true,
      },
    }
  end,
}
