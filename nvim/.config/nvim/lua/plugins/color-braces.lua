return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("rainbow-delimiters.setup").setup({  -- ✅ .setup()
        strategy = {
          [""] = function(bufnr)
            local parser = vim.treesitter.get_parser(bufnr, nil, { error = false })  -- ✅
            if not parser then return nil end
            return require("rainbow-delimiters").strategy["global"]
          end,
        },
        query = {
          lua        = "rainbow-delimiters",
          c          = "rainbow-delimiters",
          cpp        = "rainbow-delimiters",
          python     = "rainbow-delimiters",
          javascript = "rainbow-delimiters",
          typescript = "rainbow-delimiters",
          rust       = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
}
