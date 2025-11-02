return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "neo-tree", -- Target the neo-tree filetype
            text = "Neo-tree", -- Text to display in the offset
            highlight = "Directory", -- Highlight group for the text
            text_align = "left", -- Align text to the left
          },
        },
      },
    })
  end,
}
