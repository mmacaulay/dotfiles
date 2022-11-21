" Matt's .vimrc

" **********************
" Plugs
" **********************

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'jeetsukumaran/vim-buffergator', { 'on': 'BuffergatorToggle' }
Plug 'jbaum98/vim-colors-solarized'
" Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gcmt/wildfire.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Raimondi/delimitMate'

" Language support
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'elzr/vim-json', { 'for': ['json'] }

call plug#end()

" **********************
" General
" **********************

" standard leader
let mapleader = ","

" use system clipboard
set clipboard=unnamed

" " Copy to clipboard
vnoremap  y  +y
nnoremap  Y  +yg_
nnoremap  y  +y
nnoremap  yy +yy

" " Paste from clipboard
nnoremap p +p
nnoremap P +P
vnoremap p +p
vnoremap P +P

" turn off swap files
set noswapfile
set nobackup
set nowb

" why don't all editors show line numbers by default?
set number

" colors
set background=dark
colorscheme solarized
set cursorline

" windows

set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

nmap <leader>hs :split<CR>
nmap <leader>vs :vsplit<CR>

" Easier moving in tabs and windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" tabs
nnoremap <Tab> :bp<CR>
nnoremap <S-Tab> :bn<CR>

" Re-open last buffer
noremap <Leader><Leader> <C-^>

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

" brackets in insert mode

inoremap {<CR> {<CR>}<Esc>ko

" whitespace

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" formatting and other tricks

" select xml text to format
vmap <leader>x :!tidy -q -i -xml<CR>

" same for json
vmap <leader>j :!python -mjson.tool<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Adjust viewports to the same size
map <Leader>= <C-w>=

" hide search highlights
nmap <silent> <leader>h :set invhlsearch<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" **********************
" Neovim specific settings
" **********************

set termguicolors
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" **********************
" GUI settings
" **********************

if exists('neovim_dot_app')
  call MacSetFont('Source Code Pro', 14)
endif

" GVIM- (here instead of .gvimrc)
if has('gui_running')
  set guioptions-=T           " Remove the toolbar
  set guioptions-=m           " Remove the menu bar
  set lines=999               " Take all available vertical space
  set guifont=Source\ Code\ Pro:h13
else
  if &term == 'xterm' || &term == 'screen'
    set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
  endif
  "set term=builtin_ansi       " Make arrow and other keys work
endif

" **********************
" filetype specific handling
" **********************

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

autocmd FileType text,markdown setlocal spell

" Treat Vagrantfile as ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

" PHP
au FileType php setl sw=4 sts=4

" Go
au FileType go setl sw=4 sts=4

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" **********************
" Plugin Configuration
" **********************

" =========== NERDTree

map <leader>n <plug>NERDTreeTabsToggle<CR>

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

let g:nerdtree_tabs_open_on_gui_startup=0

" =========== ag

nmap <leader>a :Ag 

" =========== Ctrl-P

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" =========== BufferGator

let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = '1'
nmap <leader>b :BuffergatorToggle<CR>


" =========== Syntastic

" standard
let g:syntastic_javascript_checkers = ['standard']

" Enable jsx formatting in .js files
let g:jsx_ext_required = 0

" =========== Undotree

nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1

" =========== javascript-libraries-syntax

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" =========== wildfire

let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
            \ "html,xml" : ["at", "it"],
            \ }
