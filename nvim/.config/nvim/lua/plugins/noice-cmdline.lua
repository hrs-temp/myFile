return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- Restored default routing to get the bordered popups back
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        {
            "rcarriga/nvim-notify",
            opts = {
                max_width = 35,  -- Even smaller width to fit 14-inch screen
                max_height = 4,  -- Very short max height
                render = "default", -- Use default render to restore the borders and icons
            }
        },
    }
}
