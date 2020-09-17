" destination: ~/.config/nvim

" [S-1] General settings

" Mouse integration
set mouse=a " Enable mouse in terminal

" Line numbers and indentation
set backspace=indent,eol,start " Make backspace work in all conditions
set ma " Set mark at current cursor location
set number " Turn on line numbers
set expandtab " Enter spaces when tab is pressed
set smarttab " Use smart tabs
set autoindent " Copy indentation from current line
set si " Turn on smart indentation

" Search
set ignorecase " Ignore case when searching
set smartcase " When searching, try to be smart about cases
set hlsearch " Highlight search results
set incsearch " Make search act like search in modern browsers
set magic " Turn on magic for regular expressions

" Brackets
set showmatch " Show matching brackets when text indicator is above them
set mat=2 " How many tenths of a second to blink

" Errors
set noerrorbells " No sound on errors

" Color and fonts
syntax enable
set encoding=utf8

" Open files from the last edited position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" [S-2] Plugins

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Plugins for general use
Plug 'preservim/nerdtree' " File system tree
Plug 'Raimondi/delimitMate' " Automatic closing of, e.g., brackets
Plug 'Konfekt/FastFold' " Better automatic code folding

" Plugins for look and feel
Plug 'patstockwell/vim-monokai-tasty' " Color scheme
Plug 'itchyny/lightline.vim' " Additional aesthetics

" Plugins specific to R development environment
Plug 'jalvesaq/Nvim-R' " Main plugin for executing R code
Plug 'ncm2/ncm2' " Dependency for ncm-R
Plug 'roxma/nvim-yarp' " Dependency for ncm-R
Plug 'gaalcaras/ncm-R' " Synchronous autocompletion in R

" Plugins specific to LaTeX editor
Plug 'lervag/vimtex' " Main plugin for LaTeX compilation
Plug 'matze/vim-tex-fold' " Simple LaTeX folding

" Plugins specific to Markdown editor
Plug 'vim-pandoc/vim-pandoc' " Main document converter package
Plug 'vim-pandoc/vim-pandoc-syntax' " Markdown syntax

" Initialize plugin system
call plug#end()

" [S-3] Plugin configuration

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer() "Enable plugin for all buffers
set completeopt=noinsert,menuone,noselect " :help Ncm2PopupOpen for more info
augroup NCM2
        " LaTeX registration
        autocmd Filetype tex call ncm2#register_source({
                \ 'name': 'vimtex',
                \ 'priority': 8,
                \ 'scope': ['tex'],
                \ 'mark': 'tex',
                \ 'word_pattern': '\w+',
                \ 'complete_pattern':g:vimtex#re#ncm2,
                \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                \ })
augroup END

" nerdtree
map <leader>nn :NERDTreeToggle<CR>

" vim-monokai-tasty
let g:vim_monokai_tasty_italic = 1 " Allow italics
colorscheme vim-monokai-tasty " Enable theme

" lightline.vim
set laststatus=2 " Tell vim we want to see the statusline
let g:lightline = {
	\ 'colorscheme':'wombat'
	\ }

" vimtex
let g:tex_flavor = 'latex'
let g:tex_conceal = ''
let g:vimtex_fold_manual = 1
let g:vimtex_latexmk_continuous = 0
let g:vimtex_compiler_progname = 'nvr'
