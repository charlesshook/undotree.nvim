--- @class UndoTreeConfig
--- @field persistent_undo boolean|nil Enable persistent undo (default: false)
--- @field undotree_dir string|nil Directory for undo files (default: nil)
--- @field undolevels integer|nil Number of undo levels to keep (default: 1000)
--- @field undoreload integer|nil Number of lines to keep in memory for undo (default: 10000)
--- @field screen_layout string|nil Layout of the undo tree screen (default: "vertical")
--- @field time_format string|nil Format for displaying timestamps (default: "%Y-%m-%d %H:%M:%S")

local M = {}

local view = require("undotree.view")

M.config = {
    persistent_undo = false,
    undotree_dir = nil,
    undolevels = 1000,
    undoreload = 10000,
    screen_layout = "layout1",
    time_format = "%Y-%m-%d %H:%M:%S",
}

--- @param opts UndoTreeConfig
function M.setup(opts)
    opts = opts or {}

    M.config.persistent_undo = opts.persistent_undo or M.config.persistent_undo
    M.config.undotree_dir = opts.undotree_dir or M.config.undotree_dir
    M.config.undolevels = opts.undolevels or M.config.undolevels
    M.config.undoreload = opts.undoreload or M.config.undoreload
    M.config.screen_layout = opts.screen_layout or M.config.screen_layout
    M.config.time_format = opts.time_format or M.config.time_format

    if M.config.persistent_undo then
        vim.opt.undofile = true
    end

    if M.config.undotree_dir then
        vim.opt.undodir = M.config.undotree_dir
        vim.fn.mkdir(M.config.undotree_dir, "p")
    end

    vim.opt.undolevels = M.config.undolevels
    vim.opt.undoreload = M.config.undoreload 
    -- For testing
    vim.opt.undodir = "test"
    vim.fn.mkdir("test", "p")
    vim.opt.undofile = true
end

function M.toggle_tree()
    view.show_window(M.config.screen_layout)
end

return M
