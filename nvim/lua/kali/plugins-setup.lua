local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- ensure packer was just installed

-- Autocommand that reloads neovim whenever you saves this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end
return require ('packer').startup(function(use)
  use ("wbthomason/packer.nvim")
  -- comment with gcc
  use ("numToStr/Comment.nvim")
  -- file explorer
  use ("nvim-tree/nvim-tree.lua")
  -- statusline
  use ("nvim-lualine/lualine.nvim")
  -- colorscheme
  use { "catppuccin/nvim", as = "catppuccin" }
  -- autocompletion
  use ("hrsh7th/nvim-cmp")
  use ("hrsh7th/cmp-buffer")
  use ("hrsh7th/cmp-path")
  -- snippets
  use ("L3MON4D3/LuaSnip")
  use ("saadparwaiz1/cmp_luasnip")
  use ("rafamadriz/friendly-snippets")
  -- managing & installing LSP servers
  use ("williamboman/mason.nvim")
  use ("williamboman/mason-lspconfig.nvim")
  -- configuring LSP 
  use ("neovim/nvim-lspconfig")
  use ("hrsh7th/cmp-nvim-lsp")
  use ({"glepnir/lspsaga.nvim", branch="main"})
  -- use ("onsails/lspkind.nvim")
  -- git integration
  use ("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
  if packer_bootstrap then
    require("packer").sync()
  end
end)

