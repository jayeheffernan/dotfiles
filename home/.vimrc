set nocompatible
filetype off

let g:yankstack_map_keys = 0
let g:polyglot_disabled = ['csv']

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
Plug 'tmsvg/pear-tree'

Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'

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

let mapleader=","
nnoremap <Space> :
vnoremap <Space> :
nnoremap <leader>w :update<return>

nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>etm :e ~/.tmux.conf<CR>
nnoremap <leader>etd :e ~/TODO.md<CR>
nnoremap <leader>ez :e ~/.zshrc<CR>
nnoremap <leader>ec :CocConfig<CR>
nnoremap <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
nnoremap <leader>ek :e ~/.config/kitty/kitty.conf<CR>
" Open new file adjacent to current file
nnoremap <leader>en :e <C-R>=expand("%:p:h") . "/" <CR>

" Open in VSCode
nnoremap <leader>vs :silent execute "!code --reuse-window --goto " . getreg("%") . ":" . line(".") . ":" . col(".")<CR>

let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = 'up:40%'
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
    execute '999wincmd ' . g:oppositedirection[a:dir]
  endif
endfunction

nnoremap <silent> <C-j> :<C-u>call <SID>JumpWindow('j')<CR>
nnoremap <silent> <C-h> :<C-u>call <SID>JumpWindow('h')<CR>
nnoremap <silent> <C-l> :<C-u>call <SID>JumpWindow('l')<CR>
nnoremap <silent> <C-k> :<C-u>call <SID>JumpWindow('k')<CR>

set signcolumn=yes

set number
set ruler
set mouse=a
set hidden
set cmdheight=2
set updatetime=300
set nojoinspaces
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
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

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


vmap <silent><leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)<CR>
augroup sql
  autocmd!
  autocmd FileType sql nnoremap <leader>R vap:'<,'>DB<CR>
" Fix for formatter not recognising #>> Postgres operator
" not working
"   autocmd FileType sql autocmd BufWritePre :%s/#>>/#>>/g<CR>
augroup END

vnoremap <leader>a :CocAction<CR>
nnoremap <leader>a :CocAction<CR>
nnoremap <leader>caa <Plug>(coc-codeaction-selected)
nnoremap <leader>caf <Plug>(coc-codeaction-file)
nnoremap <leader>cal <Plug>(coc-codeaction-file)
vnoremap <leader>cai :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>
nmap <leader>cr <Plug>(coc-rename)
nmap <silent><leader>cf <Plug>(coc-fix)
nnoremap ge :call CocAction('diagnosticNext')<CR>
nnoremap gE :call CocAction('diagnosticPrevious')<CR>
nnoremap <silent><leader>ce :<C-u>CocList diagnostics<CR>
nnoremap <leader>cl :<C-u>CocListResume<CR>
nnoremap <leader>cL :<C-u>CocList<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <leader>Sl :CocList snippets<CR>
nnoremap <leader>Se :CocCommand snippets.editSnippets<CR>
nnoremap <leader>So :CocCommand snippets.openSnippetFiles<CR>

nmap <leader>drr <Plug>VimspectorContinue
nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dq <Plug>VimspectorStop
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
" for normal mode - the word under the cursor
nmap <leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <leader>di <Plug>VimspectorBalloonEval

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
inoremap <expr><Tab> <SID>handle_tab()

function! s:handle_tab()
  " Confirm completion *if selected*
  " .selected is -2 if there is only one option available and it's selected :/
  if pumvisible() && complete_info().selected != -1
    return "\<C-r>=coc#_select_confirm()\<CR>"
  " Expand snippet if available
  elseif coc#expandableOrJumpable()
    return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
  elseif pumvisible()
    return "\<C-r>=coc#_select_confirm()\<CR>"
  else
  " Just a tab
    return "\<tab>"
  endif
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
vnoremap <leader>g :WebSearchVisual<CR>

let g:db = 'postgresql://postgres:@localhost:5432/ludwig'
let g:omni_sql_no_default_maps = 1 "https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/cmop4zh/

let g:vimspector_enable_mappings = 'HUMAN'
