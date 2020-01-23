" Clear autocommands to avoid running twice
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'luochen1990/rainbow'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdcommenter'
Plugin 'xevz/vim-squirrel'
Plugin 'patstockwell/vim-monokai-tasty'
Plugin 'justinj/vim-react-snippets'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'aquach/vim-http-client'
Plugin 'othree/yajs.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ternjs/tern_for_vim'
Plugin 'kana/vim-textobj-user'
Plugin 'rhysd/vim-textobj-conflict'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'glts/vim-cottidie'
Plugin 'mattn/emmet-vim'
Plugin 'prettier/vim-prettier'
call vundle#end()
"For plugin manager
filetype plugin indent on

"For snipmate plugin
syntax on

"For CtrlP plugin
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = '~'
let g:ctrlp_user_command = 'ag %s --files-with-matches --nocolor --column --path-to-ignore ./.agignore --ignore .git --ignore node_modules --hidden -g ""'

" Disable "sorting" in most recently used mode so that most recent is
" first selected by default
let g:ctrlp_mruf_default_order = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn|gradle|idea)|node_modules|build|builds)$',
  \ 'file': '\v\.(exe|so|dll|swp|swo|pyc)$',
  \ }

let g:syntastic_javascript_checkers=['eslint']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

" yank overwritten visual text
vnoremap p <esc>pgvd

nnoremap <leader>R :redraw!<cr>

" edit a todo file
" noremap <leader>t :e TODO.md<cr>
nnoremap <leader>tt :TernType<cr>
nnoremap <leader>td :TernDef<cr>
nnoremap <leader>tr :TernRefs<cr>
" Close preview window when done completing
autocmd CompleteDone * pclose

nnoremap <leader>l :set list!<CR>

" nnoremap <BS> mzA<BS><ESC>`z
nnoremap  
cnoremap  

nnoremap K mzkJ`z
"For yankstack plugin
let g:yankstack_map_keys = 0
call yankstack#setup()
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

nnoremap <Space> :
vnoremap <Space> :
nnoremap <leader>w :update<return>

nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>s :source %<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader># :.!sh<CR>

nnoremap <leader>u :UltiSnipsEdit<return>

"Switch to alternate buffer
nnoremap <leader><space> :buffer #<return>

"ack.vim
if executable('ag')
  " let g:ackprg = 'ag --vimgrep'
  let g:ackprg="ag --nogroup --nocolor --column --path-to-ignore ./.agignore --hidden --ignore .git --ignore node_modules --mmap"
endif
nnoremap <leader>a :Ack! ''OD
nnoremap <leader>A :Ack! -F ''OD
let g:ack_mappings = {
    \"t": "<C-W><CR><C-W>T",
    \"T": "<C-W><CR><C-W>TgT<C-W>j",
    \"o": "<CR>",
    \"O": "<CR><C-W><C-W>:ccl<CR>",
    \"go": "<CR><C-W>j",
    \"h": "<C-W><CR><C-W>K",
    \"H": "<C-W><CR><C-W>K<C-W>b",
    \"v": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
    \"gv": "<C-W><CR><C-W>H<C-W>b<C-W>J",
    \"m": '<CR>zz',
    \}


"Toggle spell-check
nnoremap <leader>S :set spell!<CR>

"Toggle highlighting of search results
nnoremap <leader>h :set hlsearch!<CR>


nnoremap <leader>b :CtrlPBuffer<return>
nnoremap <leader>r :CtrlPMRUFiles<return>

nnoremap <Leader>f :let &foldmethod = (&foldmethod == "manual" ? "indent" : "manual") <bar> set foldmethod? <CR>

nnoremap <Leader>f :PrettierAsync<CR>

"Toggle rainbow parens plugin
nnoremap <leader><leader>r :RainbowToggle<CR>

" Easy insert ; for javascript
nnoremap <leader>; mzA;`z
nnoremap <leader>, mzA,`z

vnoremap <leader>d :Linediff<enter>

nnoremap <leader>B :e builds/device.nut<enter>l

"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsSnippetDirectories = [ 'UltiSnips', $HOME.'/.vim/UltiSnips/', $HOME.'/.vim/bundle/vim-snippets/UltiSnips/']
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

autocmd BufRead,BufNewFile */temp/*.nut setlocal nomodifiable
autocmd BufRead,BufNewFile */builds/*.nut setlocal nomodifiable

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" To make resizing splits with mouse work
set ttymouse=xterm2

" Show line number in margin
set number

set mouse=a

set colorcolumn=100

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Search for string while typing i.e. before hitting enter
set incsearch
set nohlsearch

"Ignore case for searches unless one or more characters in search string are
"uppercase
set ignorecase
set smartcase

"set complete-=k complete+=k
set dictionary=/usr/share/dict/words

"Automatically open all folds upon reading buffer
autocmd BufRead * normal zR

"Language for spell-check
set spelllang=en_au
set nospell

"Use vertical splits for diff mode (and show filler lines for when lines are
"added/removed in one buffer, as in default)
set diffopt=filler,vertical

colorscheme vim-monokai-tasty

" Required for transparent background:
" highlight Normal ctermbg=NONE
set smartindent
set foldmethod=manual
set ruler
" So we don't have to save before changing buffers:
set hidden
" How many spelling-suggestions to offer
set sps=best,6

set hls

" Indent the rest of broken lines
set breakindent

" Always report number of lines changed by ex commands
set report=0

let g:rainbow_active = 1

" Get tips
autocmd VimEnter,BufWritePost * CottidieTip

let g:ale_linters = { 'javascript': [ 'eslint' ] }
let g:ale_fixers = { 'javascript': [ 'eslint' ] }

let g:prettier#config#tab_width = 4
