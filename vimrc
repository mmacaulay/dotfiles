" Matt's vimrc
"
" Resources used to build this:
" YADR: https://github.com/skwp/dotfiles
" Janus: https://github.com/carlhuda/janus
" SPF13: https://github.com/spf13/spf13-vim
"

" Vundle

source ~/.vimrc.bundles

" =========== General

set nocompatible
set background=dark
set cursorline
syntax on
set encoding=utf-8
set history=1000
set visualbell "No sounds
set autoread "Reload files changed outside vim
set t_Co=256
set mouse=a " Automatically enable mouse usage
set mousehide " Hide the mouse cursor while typing
"set virtualedit=all " Set to 'onemore' to allow for cursor beyond last character
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility

" turn off swap files
set noswapfile
set nobackup
set nowb

filetype plugin indent on

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

autocmd FileType text,markdown setlocal spell

autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby

"au FileType php setl sw=4 sts=4

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Automatically load .vimrc source when saved
" autocmd BufWritePost .vimrc source $MYVIMRC

" Maximum text width being inserted before wrapping occurs.
" :set paste will disable this.
set textwidth=78
set formatoptions=cqron1j
set colorcolumn=78

" =========== UI

" sets the terminal title
set title

" These get set by airline/powerline
"set showmode "Show current mode
"set ruler                   " Show the ruler
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids

set showcmd                 " Show partial commands in status line and
                            " Selected characters/lines in visual mode
set backspace=indent,eol,start "Allow backspace in insert mode
set number
set showmatch                   " Show matching brackets/parenthesis
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Colorscheme

"let g:solarized_termcolors=256
" let g:solarized_termtrans=1
" let g:solarized_contrast="normal"
" let g:solarized_visibility="normal"
color solarized

" Allow git gutter to set the SignColumn colour to match LineNr
highlight clear SignColumn

set laststatus=2

" vim-airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" =========== Key (re)mapping

" standard leader
let mapleader = ","

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

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier formatting
nnoremap <silent> <leader>q gwip

" =========== Misc?

set clipboard=unnamed

nnoremap <Tab> :bp<CR>
nnoremap <S-Tab> :bn<CR>

" Re-open last buffer
noremap <Leader><Leader> <C-^>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" One less key to hit...
nnoremap ; :

" Yank the entire buffer into z
nnoremap <leader>ya ggvG$"zy

" =========== ag

nmap <leader>a :Ag 

" =========== Ctrl-P

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': s:ctrlp_fallback
\ }

" CtrlP extensions
let g:ctrlp_extensions = ['funky']

"funky
nnoremap <Leader>fu :CtrlPFunky<Cr>

" =========== NERDTree

map <C-e> <plug>NERDTreeTabsToggle<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
"let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" launch NERDTree automatically
"autocmd vimenter * if !argc() | NERDTree | endif
" quit if last remaining window is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" =========== Undotree

nnoremap <Leader>u :UndotreeToggle<CR>
" If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1

" =========== Tabularize

nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" =========== Indent Guides

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"let g:indent_guides_enable_on_vim_startup = 1

" =========== Wildfire

let g:wildfire_objects = {
            \ "*" : ["i'", 'i"', "i)", "i]", "i}", "ip"],
            \ "html,xml" : ["at"],
            \ }


" =========== BufferGator

let g:buffergator_viewport_split_policy = 'R'
let g:buffergator_suppress_keymaps = '1'
nmap <leader>b :BuffergatorToggle<CR>

" =========== Tagbar

nmap <leader>t :TagbarToggle<CR>

" =========== Tabs

nmap <c-t> :tabnew<CR>

" =========== Windows

set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

nmap <leader>hs :split<CR>
nmap <leader>vs :vsplit<CR>

" Easier moving in tabs and windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

" =========== Wild Menu

set wildmode=list:longest
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.class,*.jar,out

" =========== Search

set incsearch "Find the next match as we type the search
set hlsearch "Hilight searches by default
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set viminfo='100,f1 "Save up to 100 marks, enable capital marks
nmap <silent> <leader>h :set invhlsearch<CR>

" =========== Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
"set undofile                " So is persistent undo ...
"set undolevels=1000         " Maximum number of changes that can be undone
"set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

" =========== Indentation

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" =========== Scrolling

set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" =========== Whitespace

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" =========== Folds

set foldmethod=indent "fold based on indent
set foldnestmax=3 "deepest fold is 3 levels
set nofoldenable "dont fold by default

" =========== Linters

" standard
" let g:syntastic_javascript_checkers = ['standard']
" autocmd bufwritepost *.js silent !standard % --format
" set autoread

" Enable jsx formatting in .js files
let g:jsx_ext_required = 0

" =========== Deoplete

let g:deoplete#enable_at_startup = 1

" =========== Formatting and other tricks

" select xml text to format
vmap <leader>x :!tidy -q -i -xml<CR>

" same for json
vmap <leader>j :!python -mjson.tool<CR>

" or format the entire buffer
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
let g:vim_json_syntax_conceal = 0

" courtest of http://vim.wikia.com/wiki/VimTip1518
nnoremap <C-X> :Hexmode<CR>
inoremap <C-X> <Esc>:Hexmode<CR>
vnoremap <C-X> :<C-U>Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" =========== GUI Settings

  " GVIM- (here instead of .gvimrc)
  if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set guioptions-=m           " Remove the menu bar
    set lines=999               " Take all available vertical space
    "set guifont=Monaco:h13
    "set guifont=Menlo:h13
    set guifont=Source\ Code\ Pro:h13
  else
    if &term == 'xterm' || &term == 'screen'
      set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
  endif

