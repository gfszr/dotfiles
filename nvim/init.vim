

"""" {{{ BASICS

autocmd! bufwritepost .vimrc source %
set pastetoggle=<F2>
set clipboard=unnamed
set mouse=a
set backspace=indent,eol,start
set clipboard=unnamed
set encoding=utf-8
syntax on
set autoindent
filetype plugin indent on
set number
set tw=99
set wrap
set fo-=t
set colorcolumn=100
set timeoutlen=200

" Coloring
set t_Co=256
highlight ColorColumn ctermbg=233
set background=dark
set cursorline
color jellybeans
set nohlsearch

" Setting history
set history=700
set undolevels=700

" Setting tabs as 4 spaces
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

" Setting smarter case
set incsearch
set ignorecase
set smartcase

" " Initialize my hotkeys, without them I'm doomed
set number
set relativenumber

"""" }}} BASICS

"""" {{{ MY CUSTOM KEY MAPPINGS

imap kj <ESC>
nnoremap ; :

vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


""" {{{ vim-airline

let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch', 'tabline']
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0

""" }}} vim-airline

""" {{{ delimitMate

let delimitMate_expand_cr = 1
au FileType mail let b:delimitMate_expand_cr = 1

""" }}} delimitMate

""" {{{ coc.nvim 

set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

nmap <leader>cl  <Plug>(coc-codelens-action)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

""" }}} coc.nvim

""" {{{ Aerojump

nmap <space> <Plug>(AerojumpSpace)

""" }}} Aerojump

""" {{{ Ultisnips

let g:UltiSnipsExpandTrigger="KK"
let g:UltiSnipsJumpForwardTrigger="KJ"

""" }}} Ultisnips

""" {{{ SingleCompile

nnoremap <F10> :SCCompileRun<cr>

""" }}} SingleCompile

""" {{{ FZF

set rtp+=/usr/local/opt/fzf

function! s:GotoOrOpen(command, ...)
  for file in a:000
    if a:command == 'e'
      exec 'e ' . file
    else
      exec "tab drop " . file
    endif
  endfor
endfunction

command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)

let g:fzf_action = {
  \ 'enter': 'GotoOrOpen tab'}

nnoremap <C-p> :Files<CR>

let g:fzf_buffers_jump = 1
if exists('$TMUX')
  " Using tmux pop-up window
    let g:fzf_layout = { 'tmux': '-p90%,80%' }
else
    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
endif

let g:fzf_buffers_jump = 1

""" }}} FZF

""" {{{ CreateCenteredFloatingWindow

function! CreateCenteredFloatingWindow()
    let width  = float2nr(&columns * 0.9)
    let height = float2nr(&lines * 0.8)
    let top    = ((&lines - height) / 2) - 1
    let left   = (&columns - width) / 2
    let opts   = { 'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }
    let top    = "╭" . repeat("─", width - 2) . "╮"
    let mid    = "│" . repeat(" ", width - 2) . "│"
    let bot    = "╰" . repeat("─", width - 2) . "╯"
    let lines  = [top] + repeat([mid], height - 2) + [bot]
    let s:buf  = nvim_create_buf(v:false, v:true)

    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, CreatePadding(opts))
    autocmd BufWipeout <buffer> exe 'bwipeout '.s:buf
endfunction

function! CreatePadding(opts)
    let a:opts.row    += 1
    let a:opts.height -= 2
    let a:opts.col    += 2
    let a:opts.width  -= 4
    return a:opts
endfunction

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
        startinsert
    else
        bwipeout!
    endif
endfunction

function! OnTermExit(job_id, code, event) dict
  if a:code == 0
    bwipeout!
  endif
endfunction
let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null }
" function! ToggleTerminalDrawer() abort
"   if win_gotoid(g:terminal_drawer.win_id)
"     hide
"     set laststatus=2 showmode ruler
"   else
"     botright new
"     if !g:terminal_drawer.buffer_id
"       call termopen('zsh', {"detach": 0})
"       let g:terminal_drawer.buffer_id = bufnr("")
"     else
"       exec 'buffer' g:terminal_drawer.buffer_id
"       call RemoveEmptyBuffers()
"     endif
"
"     exec 'resize' float2nr(&lines * 0.25)
"     setlocal laststatus=0 noshowmode noruler
"     setlocal nobuflisted
"     echo ''
"     startinsert!
"     let g:terminal_drawer.win_id = win_getid()
"
"     tnoremap <buffer><Esc> <C-\><C-n>
"     nnoremap <buffer><silent><Esc> :q<cr>
"     nnoremap <buffer><silent> q :q<CR>
"   endif
" endfunction

function! RemoveEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
      silent exe 'bw ' . join(buffers, ' ')
  endif
endfunction
""" }}} CreateCenteredFloatingWindow

""" {{{ Floaterm
let g:floaterm_title = ""
hi FloatermBorder guibg=orange guifg=cyan

function! CreateOrToggleFloaterm(name, arguments)
    if index(floaterm#cmdline#complete_names1(), a:name) == -1
        exec "FloatermNew --name=" . a:name . " " . a:arguments
    else
        exec "FloatermToggle " . a:name
        if &filetype == 'floaterm'
            startinsert
        endif
    endif
endfunction

function! HideAllFloaterms()
    for name in floaterm#cmdline#floaterm_names()
        exec "FloatermHide " . name
    endfor
endfunction

tnoremap <silent><leader>h <C-\><C-n>:call HideAllFloaterms()<CR>

function! ConfigFloaterm(binding, name, arguments)
    exec 'nnoremap <silent><leader>' . a:binding . ' :call CreateOrToggleFloaterm("' . a:name . '","' . a:arguments . '")<CR>'
    exec 'tnoremap <silent><leader>' . a:binding . ' <C-\><C-n>:call CreateOrToggleFloaterm("' . a:name . '", "' . a:arguments . '")<CR>'
endfunction

call ConfigFloaterm('t', 'zsh', 'zsh')
call ConfigFloaterm('p', 'ipython', 'ipython')

function! CreateTmuxPopup(command)
    call system("tmux popup -h 80\% -w 90\% -d " . getcwd() . " -E " . a:command)
endfunction

nnoremap <leader>g :call CreateTmuxPopup('lazygit')<CR>
nnoremap <leader>d :call CreateTmuxPopup('git diff')<CR>


let g:floaterm_borderchars =  ['─', '│', '─', '│', '╭', '╮', '╯', '╰']
let g:floaterm_autoclose = v:true
let g:floaterm_wintitle = v:false
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

""" }}} Floaterm

""" {{{ vimspector
let g:vimspector_enable_mappings = 'HUMAN'
""" }}} vimspector

