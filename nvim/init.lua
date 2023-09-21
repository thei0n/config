--Theion's nvim config, if you don't like it you are wrong!


--[[Packages]]
require('packer').startup(function(use)
	use { "ellisonleao/gruvbox.nvim", as="gruvbox" }
	use {'wbthomason/packer.nvim'}
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
	use 'voldikss/vim-floaterm'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}

	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

end)

--[[Vim settings]]
vim.cmd("packadd packer.nvim")

vim.cmd("set clipboard+=unnamedplus") --Use System Clipboard

vim.cmd([[set number]]) 

vim.cmd([[set scrolloff=5]]) --Smooth scroll

vim.o.background = "dark" -- or "light" for light mode
	
vim.cmd([[colorscheme gruvbox]]) --Color Scheme

--I have no idea what these are 
--They were in my old nvim config so put them here, just in case they do something important
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.laststatus=0
--vim.cmd([[LspStop]]) 

--[[Mappings]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.laststatus=0

vim.keymap.set('n','<leader><leader>',':w!<CR>')
vim.keymap.set('n','<leader>q',':wqa!<CR>')
vim.keymap.set('n','<leader>f',':FloatermToggle<CR>')
vim.keymap.set('n','<leader>e', ':NvimTreeFindFileToggle<CR>')
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

--[[ LSP ]]  
require("mason").setup() 
require("mason-lspconfig").setup({
	ensure_installed = {"clangd"},
})

require("lsp.mason")
local lsp = require('lsp-zero')

lsp.preset("recommended")
local cmp = require("cmp")

local cmp_select = {behavior = cmp.SelectBehavior.Select}

local cmp_mappings = lsp.defaults.cmp_mappings({
	["<A-f>"] = cmp.mapping.select_next_item(cmp_select), ["<A-d>"] = cmp.mapping.select_prev_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({ select = false }),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
end)

-- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "c", "bash", "rust", "go"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript", "vim", "lua", "csharp", "cpp" },

   highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }, } 
