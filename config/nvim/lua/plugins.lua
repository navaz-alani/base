require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- lsp & related
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	-- deps of: nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- utilities
	use 'junegunn/fzf.vim'

	-- look and feel
	use {
		'kyoz/purify',
		as = 'purify',
		rtp = 'vim',
		config = 'vim.cmd[[ colorscheme purify ]]',
	}
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'APZelos/blamer.nvim'

	use {
	  'lewis6991/gitsigns.nvim',
	  requires = {
	    'nvim-lua/plenary.nvim'
	  },
	}
end)
