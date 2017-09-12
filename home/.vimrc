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
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'xevz/vim-squirrel'
Plugin 'sickill/vim-monokai'
Plugin 'justinj/vim-react-snippets'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'jiangmiao/auto-pairs'
Plugin 'aquach/vim-http-client'
Plugin 'othree/yajs.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ternjs/tern_for_vim'
Plugin 'kana/vim-textobj-user'
Plugin 'rhysd/vim-textobj-conflict'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'wakatime/vim-wakatime'
call vundle#end()
"For plugin manager
filetype plugin indent on

"For snipmate plugin
syntax on

"For CtrlP plugin
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = '~'

" Disable "sorting" in most recently used mode so that most recent is
" first selected by default
let g:ctrlp_mruf_default_order = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|swp)$',
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
nnoremap <leader>w :w<return>

nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>s :source %<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader># :.!sh<CR>

nnoremap <leader>u :UltiSnipsEdit<return>

"Switch to alternate buffer
nnoremap <leader><space> :buffer #<return>
"
"ack.vim
if executable('ag')
  "let g:ackprg = 'ag --vimgrep'
  let g:ackprg='ag --nogroup --nocolor --column --path-to-ignore ./.agignore --hidden --ignore .git --ignore node_modules'
endif
nnoremap <leader>a :Ack ''OD
nnoremap <leader>A :Ack -F ''OD

"Toggle spell-check 
nnoremap <leader>S :set spell!<CR>

"Toggle highlighting of search results
nnoremap <leader>h :set hlsearch!<CR>


nnoremap <leader>b :CtrlPBuffer<return>
nnoremap <leader>r :CtrlPMRUFiles<return>

"Reflow paragraph
" nnoremap <Leader>f gqip
if !exists("*ToggleFold")
  function ToggleFold()
    let &foldmethod = (&foldmethod == "manual") ?  "indent" : "manual"
    echo &foldmethod
  endfunction
endif

nnoremap <Leader>f :call ToggleFold()<CR>

"Toggle rainbow parens plugin
nnoremap <leader><leader>r :RainbowParenthesesToggle<CR>

" "Easy window switching
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>h :HTTPClientDoRequest<cr>

" Easy insert ; for javascript
nnoremap <leader>; mzA;`z

vnoremap <leader>d :Linediff<enter>

let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsSnippetDirectories = [ 'UltiSnips', $HOME.'/.vim/UltiSnips/', $HOME.'/.vim/bundle/vim-snippets/UltiSnips/']
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

autocmd FileType javascript UltiSnipsAddFiletypes javascript-jsdoc
autocmd FileType javascript UltiSnipsAddFiletypes javascript
autocmd FileType squirrel UltiSnipsAddFiletypes javascript-jsdoc
autocmd FileType squirrel UltiSnipsAddFiletypes squirrel

nnoremap gy "*y
vnoremap gy "*y
nnoremap gd "*d
vnoremap gd "*d
nnoremap gp "*p
vnoremap gp "*p
nnoremap gP "*P
vnoremap gP "*P
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Show line number in margin
set number

set mouse=a

"set tabstop=4
"Backspacing an expanded tab deletes space of tab, not just a single space
"set softtabstop=4
"set expandtab
"set shiftwidth=4

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

colorscheme monokai
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
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
