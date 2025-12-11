" Matt's .vimrc

" **********************
" General
" **********************

" standard leader
let mapleader = ","

" use system clipboard
set clipboard=unnamed

" turn off swap files
set noswapfile
set nobackup
set nowb

" why don't all editors show line numbers by default?
set number

" colors
set background=dark
"colorscheme solarized
set cursorline

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" indentation

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" whitespace

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" hide search highlights
nmap <silent> <leader>h :set invhlsearch<CR>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif