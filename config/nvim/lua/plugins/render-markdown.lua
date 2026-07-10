return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    heading = {
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      width = 'block',
      left_pad = 0,
      right_pad = 0,
    },
    code = {
      width = 'block',
      left_pad = 0,
      right_pad = 0,
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
    },
    bullet = {
      enabled = true,
      icons = { '+', '*', '-' },
    },
    pipe_table = { preset = 'round' },
    highlight = { enabled = true },
    latex = { enabled = true },
    link = { enabled = true },
    win_options = {
      conceallevel = { rendered = 2, default = 1 },
      concealcursor = { rendered = 'nc', default = 'nc' },
    },
  },
  ft = { 'markdown' },
}
