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
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sickill/vim-monokai'
Plugin 'justinj/vim-react-snippets'
Plugin 'mileszs/ack.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'aquach/vim-http-client'
call vundle#end()
"For plugin manager
filetype plugin indent on

"Use ag with ack.vim
let g:ackprg='ag --nogroup --nocolor --column'

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

nnoremap <leader>v :e ~/.vimrc<cr>

nnoremap <leader>d :bd<cr>

"For yankstack plugin
let g:yankstack_map_keys = 0
call yankstack#setup()
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste 

nnoremap <Space> :
vnoremap <Space> :
nnoremap <leader>w :w<return>

nnoremap <leader>a :Ack 

nnoremap <leader>s :source %<CR>

"Toggle highlighting of search results
nnoremap <leader>h :set hlsearch!<CR>

"Buffer selector, ordered by last accessed
"nnoremap <leader>b :BufstopFast<return>

nnoremap <leader>b :CtrlPBuffer<return>
nnoremap <leader>r :CtrlPMRUFiles<return>

"Reflow paragraph
nnoremap <Leader>f gqip

"Toggle rainbow parens plugin
nnoremap <leader><leader>r :RainbowParenthesesToggle<CR>

"Easy window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>h :HTTPClientDoRequest<cr>

" Easy insert ; for javascript
nnoremap <leader>; mzA;`z

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show line number in margin
set number

set tabstop=4
"Backspacing an expanded tab deletes space of tab, not just a single space
set softtabstop=4
set expandtab
set shiftwidth=4

set colorcolumn=80

" Search for string while typing i.e. before hitting enter
set incsearch
set nohlsearch

"Ignore case for searches unless one or more characters in search string are
"uppercase
set ignorecase
set smartcase

"set complete-=k complete+=k
set dictionary=/usr/share/dict/cracklib-small

"Automatically open all folds upon reading buffer
autocmd BufRead * normal zR

"Language for spell-check
set spelllang=en_au
set nospell

"Use vertical splits for diff mode (and show filler lines for when lines are
"added/removed in one buffer, as in default)
set diffopt=filler,vertical

colorscheme monokai
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Required for transparent background:
highlight Normal ctermbg=NONE
set autoindent
"set foldmethod=manual
set foldmethod=manual
set ruler
" So we don't have to save before changing buffers:
set hidden
" How many spelling-suggestions to offer
set sps=best,6
