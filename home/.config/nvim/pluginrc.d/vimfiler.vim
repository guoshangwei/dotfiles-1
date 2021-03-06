let g:vimfiler_as_default_explorer = 1
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_readonly_file_icon = ''
let g:vimfiler_ignore_pattern = [
            \ '\.py[cd]$',
            \ '\~$',
            \ '\.swo$',
            \ '\.swp$',
            \ '^\.git$',
            \ '^\.hg$',
            \ '^\.svn$',
            \ '^\.bzr$',
            \ '^\.DS_Store$',
            \ ]

augroup vimfiler_group
    autocmd!
    " double click to open file
    autocmd FileType vimfiler nmap <buffer> <2-LeftMouse> <Plug>(vimfiler_edit_file)
    " auto close if it is the last
    autocmd BufEnter * if (&buftype ==# 'vimfilter' || &buftype ==# 'nofile')
                \ && (!has('vim_starting'))
                \ && winbufnr(2) == -1 | quit! | endif
augroup END

" Edit file by tabedit and overwrite default webdevicon style
let g:webdevicons_enable_vimfiler = 0
call vimfiler#custom#profile('default', 'context', {
            \ 'edit_action' : 'tabopen',
            \ 'columns' : 'devicons:size:time',
            \ 'explorer_columns': 'devicons:space',
            \ })

map <C-e> :VimFilerExplorer -parent<CR>
