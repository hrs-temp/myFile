return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      auto_install = true,

      -- stripping its control over the ui
      -- highlight = { enable = true },
      -- indent = { enable = true },
    })
  end
}
