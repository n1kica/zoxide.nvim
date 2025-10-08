# zoxide.nvim

Neovim plugin for [zoxide](https://github.com/ajeetdsouza/zoxide) integration.

## Requirements

- Neovim 0.10+
- [zoxide](https://github.com/ajeetdsouza/zoxide) installed

## Installation

**lazy.nvim:**
```lua
{
  "n1kica/zoxide.nvim",
  cmd = "Z",
  opts = {}
}
```

## Usage

```vim
:Z <query>
```

Changes Neovim working directory using zoxide's database of frequently used directories.

## Examples

```vim
:Z nvim
:Z Docu
```
