return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      auto_install = true,

      -- Allow treesitter to control the ui highlighting so the theme applies correctly
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
