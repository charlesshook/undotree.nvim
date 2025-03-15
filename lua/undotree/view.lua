local vim = vim
local M = {}

--- @type integer|nil
local undotree_buff = nil
--- @type integer|nil
local undotree_win = nil

local function set_display_buffer_options(buff)
    -- buftype: not associated with a file
    -- bufhidden: delete the buffer when it is no longer displayed
    -- swapfile: do not create a swap file for this buffer
    vim.bo[buff].buftype = "nofile"
    vim.bo[buff].bufhidden = "wipe"
    vim.bo[buff].swapfile = false
end

local function create_buffers()
    undotree_buff = vim.api.nvim_create_buf(false, true)

    set_display_buffer_options(undotree_buff)
end


local function open_layout1()
    vim.cmd("topleft vnew")
    undotree_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(undotree_win, undotree_buff)

    local total_cols = vim.o.columns
    local undotree_cols = math.floor(total_cols / 3)
    vim.api.nvim_win_set_width(undotree_win, undotree_cols)
end

--- @param layout string
local function create_window(layout)
    if layout == "layout1" then
        open_layout1()
    elseif layout == "layout2" then
        return
    elseif layout == "layout3" then
        return
    elseif layout == "layout4" then
        return
    end
end

local function format_time(timestamp)
    if not timestamp or timestamp == 0 then return "" end
    return os.date("%Y-%m-%d %H:%M:%S", timestamp)
  end
  
  local function build_tree(entries, level, prefix)
    local lines = {}
    level = level or 0
    prefix = prefix or ""
  
    for i, entry in ipairs(entries or {}) do
      local is_last = (i == #entries)
      local branch = is_last and "└── " or "├── "
  
      local mark = (entry.seq == vim.fn.undotree().seq_cur) and "●" or "○"
      local time_str = format_time(entry.time)
      local label = string.format("%s%s%s %d  [%s]",
        prefix,
        branch,
        mark,
        entry.seq,
        time_str
      )
  
      table.insert(lines, label)
  
      local new_prefix = prefix .. (is_last and "    " or "│   ")
  
      if entry.alt and type(entry.alt) == "table" and #entry.alt > 0 then
        local branch_lines = build_tree(entry.alt, level + 1, new_prefix)
        vim.list_extend(lines, branch_lines)
      end
    end
  
    return lines
  end

local function render_tree(tree)
    local lines = {}
  
    if not tree.entries or #tree.entries == 0 then
      lines = {
        "No undo history yet.",
        "Make some changes and see them appear!",
      }
    else
      lines = build_tree(tree.entries, 0)
      table.insert(lines, 1, "Undotree")
      table.insert(lines, 2, "--------------------")
    end
  
    vim.api.nvim_buf_set_option(undotree_buff, "modifiable", true)
    vim.api.nvim_buf_set_lines(undotree_buff, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(undotree_buff, "modifiable", false)
  end

--- @param layout string
function M.show_window(layout)
    local tree = vim.fn.undotree()
    print(vim.inspect(tree))
    create_buffers()
    create_window(layout)
    render_tree(tree)
  end

return M
