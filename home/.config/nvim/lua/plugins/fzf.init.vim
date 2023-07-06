" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Project-level Rg (takes search-term) and RG (live reload while typing search-term)
command! -bang -nargs=* PRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), fzf#vim#with_preview({'dir': luaeval('require("lazyvim.util").get_root()')}), <bang>0)
command! -bang -nargs=* PRG call fzf#vim#grep2("rg --column --line-number --no-heading --color=always --smart-case -- ", <q-args>, fzf#vim#with_preview({'dir': luaeval('require("lazyvim.util").get_root()')}), <bang>0)

command! -bang -nargs=* WikiRg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), fzf#vim#with_preview({'dir': '~/.vimwiki/notes'}), <bang>0)
command! -bang -nargs=* WikiRG call fzf#vim#grep2("rg --column --line-number --no-heading --color=always --smart-case -- ", <q-args>, fzf#vim#with_preview({'dir': '~/.vimwiki/notes'}), <bang>0)
