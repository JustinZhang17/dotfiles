return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- AI Code Companion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp", 
      "nvim-telescope/telescope.nvim", 
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "githubmodels", 
            roles = {
              llm = "CodeCompanion",
              user = "Justin",
            },          
          },
          inline = {
            adapter = "githubmodels",
          },
        },
        display = {
          chat = {
            window = {
              layout = "vertical",
              width = 0.3,
            },
          },
          action_palette = {
            provider = "telescope", 
          },
        },

        opts = {
          send_code = true,
          system_prompt = "You are an expert developer. Respond concisely with highly optimized code.",
        }
      })
    end,
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
  },
}
