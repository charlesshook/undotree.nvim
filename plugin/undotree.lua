vim.api.nvim_create_user_command("UndotreeToggle", function()
    require("undotree").toggle_tree()
end, {})
