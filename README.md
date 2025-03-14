<div align="center">

# undotree.nvim
##### Helping you undo your mistakes (or mostly mine).

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](https://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

</div>

Vim has a feature called Undotree which allows you to visualize the undo branches
of your file. What are _undo branches_? They are a feature of vim undotree that alows
you to go back to a prior state even if it has been overwritten by a later change.
Vim internally stores the entire history of changes of your file in a monolithic
tree. This plugin allows you to visualize that tree and navigate through it.

## Installation

### Using lazy.nvim

```lua
{
  'charlesshook/undotree.nvim',
  config = function()
    require('undotree').setup()
  end
}
```

## Usage
- `:UndotreeToggle` - Open the undotree window

## Configuration

Here is a list of all the possible configuration options:

-- Enable persistent undo (default: false)
```persistent_undo```




   
