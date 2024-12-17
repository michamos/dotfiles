return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = vim.cmd.TSUpdate,
        main = "nvim-treesitter.configs",
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "yaml", "toml", "json" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = false,
                    node_incremental = " ",
                    scope_incremental = false,
                    node_decremental = " ",
                },
            },
        },
    },
    { "nvim-treesitter/nvim-treesitter-context" },
}
