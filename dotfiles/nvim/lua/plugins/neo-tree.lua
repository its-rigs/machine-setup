return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = {
              '.git',
              '.DS_Store',
            },
            never_show = {},
          },
        },
      })

      vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left toggle<CR>")
      vim.keymap.set("n", "<leader>fe", ":Neotree filesystem focus<CR>")
    end,
  },
}
