set nocompatible
filetype off

let g:yankstack_map_keys = 0
let g:polyglot_disabled = ['csv']
let g:gitgutter_map_keys = 0

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()

Plug 'chriskempson/base16-vim'

" Utilities
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tmsvg/pear-tree'

Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'itchyny/lightline.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Cool stuff
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'junegunn/vim-easy-align'
Plug 'simnalamburt/vim-mundo'
Plug 'lifepillar/vim-cheat40'
Plug 'linluk/vim-websearch'
" note: install sharkdp/bat for syntax-highlighted fzf preview 
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dadbod'
" Completion for DB objects, e.g. table names
Plug 'kristijanhusak/vim-dadbod-completion', {'do': 'yarn install --frozen-lockfile'}

" Debugger integration
Plug 'puremourning/vimspector'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" COC plugins
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-emmet', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-styled-components', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-svg', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
Plug 'pantharshit00/coc-prisma', {'do': 'yarn install --frozen-lockfile'}
Plug 'pantharshit00/vim-prisma', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-tailwindcss', {'do': 'yarn install --frozen-lockfile'}
" Use FZF to navigate COC lists
Plug 'antoinemadec/coc-fzf'
" TODO review - don't necessarily need this, but it sounds interesting
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}

Plug 'lifepillar/pgsql.vim'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
" Snippet definitions
Plug 'honza/vim-snippets'

" TODO: consider tabnine

Plug 'sheerun/vim-polyglot'
call plug#end()

call yankstack#setup()
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

let g:cheat40_use_default = 0

" Load base16-shell colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

syntax on
filetype plugin indent on

let mapleader=" "
nnoremap ' :
vnoremap ' :
nnoremap <leader>w :update<return>

let maplocalleader=","

nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>etm :e ~/.tmux.conf<CR>
nnoremap <leader>etd :e ~/TODO.md<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>ec :CocConfig<CR>
nnoremap <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
nnoremap <leader>ek :e ~/.config/kitty/kitty.conf<CR>
nnoremap <leader>eg :e ~/.gitconfig<CR>
" Open new file adjacent to current file
nnoremap <leader>en :e <C-R>=expand("%:p:h") . "/" <CR>

function OpenInVsCode()
  let git_root = fnameescape(trim(system("git rev-parse --show-toplevel")))
  let goto = join([fnameescape(getreg("%")), ":", line("."), ":", col(".")], '')
  let command = "code '" . git_root . "' --goto '" . goto . "'"
  execute "!" . command
endfunction
nnoremap <leader>vs :silent call OpenInVsCode()<CR>

function OpenPage()
    execute "!yarn open-page " . fnameescape(getreg("%"))
endfunction

function OpenPageDev()
    execute "!yarn open-page-dev " . fnameescape(getreg("%"))
endfunction

let g:fzf_layout = { 'down': '50%' }
let g:fzf_preview_window = 'up:50%'
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :History<CR>
nnoremap <leader>s :Rg<Space>
nnoremap <leader><Up> :buffer #<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>Q :bd!<CR>

nnoremap <leader>l :set list!<CR>

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap gA :EasyAlign
xmap gA :EasyAlign

" Use system clipboard
nnoremap <leader><leader>d "+d
vnoremap <leader><leader>d "+d
nnoremap <leader><leader>y "+y
vnoremap <leader><leader>y "+y
nnoremap <leader><leader>p "+p
nnoremap <leader><leader>P "+P
vnoremap <leader><leader>p "+p
vnoremap <leader><leader>P "+P

nnoremap <leader>yF :let @+=expand("%:p")<CR>
nnoremap <leader>yf :let @+=expand("%")<CR>

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

nnoremap <leader>u :MundoToggle<CR>

let g:oppositedirection = { 'h': 'l', 'l': 'h', 'j': 'k', 'k': 'j' }
function! s:JumpWindow(dir)
  let l:prev = winnr()
  execute 'wincmd ' . a:dir
  if winnr() == l:prev
    execute '99wincmd ' . g:oppositedirection[a:dir]
  endif
endfunction

nnoremap <silent> <C-j> :<C-u>call <SID>JumpWindow('j')<CR>
nnoremap <silent> <C-h> :<C-u>call <SID>JumpWindow('h')<CR>
nnoremap <silent> <C-l> :<C-u>call <SID>JumpWindow('l')<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>JumpWindow('k')<CR>

" Keep search results at the center of screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

set signcolumn=yes

set number
set ruler
set mouse=a
set hidden
set cmdheight=1
set updatetime=300
set nojoinspaces
set hlsearch incsearch ignorecase smartcase
set modelines=0
set nostartofline
set nofixendofline
set cursorline

set undofile

" To make this work properly: in insert mode, escape, followed by arrow key
" (very rapidly)
set ttimeoutlen=0

set encoding=utf-8
set fenc=utf-8

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if (has('nvim'))
  set termguicolors
else
  " To make resizing splits with mouse work
  set ttymouse=xterm2
endif

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:sql_type_default = 'pgsql'

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction'
  \ },
  \ }

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

vmap <silent><leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)<CR>
augroup sql
  autocmd!
  autocmd Filetype sql vnoremap <silent><leader>f !pg_format<CR>
  autocmd Filetype sql nnoremap <silent><leader>f ggVG!pg_format<CR>
  autocmd FileType sql nnoremap <leader>R vap:'<,'>DB<CR>
augroup END

vnoremap <localleader>a :CocAction<CR>
nnoremap <localleader>a :CocAction<CR>
nnoremap <localleader>caa <Plug>(coc-codeaction-selected)
nnoremap <localleader>caf <Plug>(coc-codeaction-file)
nnoremap <localleader>cal <Plug>(coc-codeaction-file)
vnoremap <localleader>cai :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
nmap <silent><localleader>d <Plug>(coc-definition)
nmap <silent><localleade>r <Plug>(coc-references)
nnoremap <silent><localleader>h :call <SID>show_documentation()<CR>
nmap <localleader>r <Plug>(coc-rename)
nmap <silent><localleader>f <Plug>(coc-fix)
nnoremap <localleader>en :call CocAction('diagnosticNext')<CR>
nnoremap <localleader>ep :call CocAction('diagnosticPrevious')<CR>
nnoremap <silent><localleader>el :<C-u>CocFzfList diagnostics<CR>
nnoremap <localleader>lr :<C-u>CocFzfListResume<CR>
nnoremap <localleader>ll :<C-u>CocFzfList<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" Disabled because they seem to freeze Vim while the language server is starting up
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

nnoremap <localleader>sl :CocList snippets<CR>
nnoremap <localleader>se :CocCommand snippets.editSnippets<CR>
nnoremap <localleader>so :CocCommand snippets.openSnippetFiles<CR>

" Git mappings
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gb :Git blame<CR>

nmap <leader>drr <Plug>VimspectorContinue
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dq <Plug>VimspectorStop
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
" for normal mode - the word under the cursor
nmap <leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <leader>di <Plug>VimspectorBalloonEval

" Use <C-l> for both expand and jump (make expand higher priority.)
imap <C-l> <Plug>(coc-snippets-expand-jump)

" Use <C-l> for select text for visual placeholder of snippet.
vmap <C-l> <Plug>(coc-snippets-select)

imap <C-h> <nop>
nmap <C-h> <nop>
vmap <C-h> <nop>
let g:coc_snippet_next = '<c-l>'
imap <C-h> <nop>
nmap <C-h> <nop>
vmap <C-h> <nop>
let g:coc_snippet_prev = '<c-h>'

inoremap <expr><Tab> <SID>handle_tab()
vnoremap <expr><Tab> <SID>handle_tab()

function! s:handle_tab()
  " Confirm completion *if selected*
  " .selected is -2 if there is only one option available and it's selected :/
  if pumvisible() && complete_info().selected != -1
    return "\<C-r>=coc#_select_confirm()\<CR>"
  " Expand snippet if available
  " elseif coc#expandableOrJumpable()
  "   return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  elseif pumvisible()
    return "\<C-r>=coc#_select_confirm()\<CR>"
  else
  " Just a tab
    return "\<tab>"
  endif
endfunction

" Auto-fix quickfix window height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Channel/runfromvim
function! s:tcpsocksendone(port, msg)
  let l:ch = sockconnect('tcp', 'localhost:' . a:port)
  call chansend(l:ch, a:msg)
  call chanclose(l:ch)
endfunction

let g:runfromvim_port = 8222
nnoremap <silent><leader>m :call <SID>tcpsocksendone(g:runfromvim_port, 'command0')<CR>
nnoremap <silent><leader>t :call <SID>tcpsocksendone(g:runfromvim_port, 'command1')<CR>

" Google plugin
let g:web_search_command = "open"
let g:web_search_query = "https://google.com/search?q="
vnoremap <leader>S :WebSearchVisual<CR>

let g:db = 'postgresql://postgres:@localhost:5432/ludwig'
let g:omni_sql_no_default_maps = 1 "https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/cmop4zh/

let g:vimspector_enable_mappings = 'HUMAN'
