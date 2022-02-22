

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
exec 'hi SignColumn ctermbg=' . synIDattr(hlID('LineNr'),'bg')
set signcolumn=yes
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
let g:airline_extensions = ['tabline']
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
hi airline_x_errors ctermfg=red 
hi airline_x_warnings ctermfg=yellow
hi airline_x_hints ctermfg=white
function! GetCocErrors()
    let stat = get(b:, 'coc_diagnostic_info', {})
    if stat == {} 
        return ''
    endif
    return " " . stat['error'] . ' '
endfunction

function! GetCocWarnings()
    let stat = get(b:, 'coc_diagnostic_info', {})
    if stat == {} 
        return ''
    endif
    return " " . stat['warning'] . ' '
endfunction

function! GetCocHints()
    let stat = get(b:, 'coc_diagnostic_info', {})
    if stat == {} 
        return ''
    endif
    return " " . stat['hint'] . ' '
endfunction

function! GetCocFunction()
    let f = get(b:, 'coc_current_function', '')
    if f ==# ''
        return f
    endif
    return '   ' . f
endfunction

function! GetGitsignsBranch()
    let d = get(b:, 'gitsigns_status_dict', {})
    let b = get(d, 'head', '')
    return b
endfunction

function! GetGitsignsBranch()
    let d = get(b:, 'gitsigns_status_dict', {})
    let b = get(d, 'head', '')
    if b ==# ''
        return b
    endif
    return ' ' . b
endfunction

function! GetCurrentFile()
    return expand("%:t")
endfunction

function! AirlineInit()
    call airline#parts#define_function('custom_coc_errors', 'GetCocErrors')
    call airline#parts#define_function('coc_current_function', 'GetCocFunction')
    call airline#parts#define_function('custom_coc_warnings', 'GetCocWarnings')
    call airline#parts#define_function('custom_coc_hints', 'GetCocHints')
    call airline#parts#define_function('gitsigns_branch', 'GetGitsignsBranch')
    call airline#parts#define_function('current_file', 'GetCurrentFile')
    call airline#parts#define_accent('custom_coc_errors', 'errors')
    call airline#parts#define_accent('custom_coc_warnings', 'warnings')
    call airline#parts#define_accent('custom_coc_hints', 'hints')
    let g:airline_section_x = airline#section#create(['custom_coc_errors', 'custom_coc_warnings', 'custom_coc_hints'])
    let g:airline_section_c = airline#section#create(['current_file', 'coc_current_function'])
    let g:airline_section_b = airline#section#create(['gitsigns_branch'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

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

hi CocErrorFloat ctermfg=red
hi CocWarningFloat ctermfg=yellow

let g:coc_borderchars =  ['─', '│', '─', '│', '╭', '╮', '╯', '╰']


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

""" }}} coc.nvim

""" {{{ Ultisnips

let g:UltiSnipsExpandTrigger="KK"
let g:UltiSnipsJumpForwardTrigger="KJ"

""" }}} Ultisnips

""" {{{ FZF

if has("mac") && system("uname -p") ==# "arm\n"
    set rtp+=/opt/homebrew/opt/fzf
else
    set rtp+=/usr/local/opt/fzf
endif

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

"" }}} Floaterm

""" {{{ vimspector
let g:vimspector_enable_mappings = 'HUMAN'
""" }}} vimspector

""" {{{ gitsigns
lua << EOF
require('gitsigns').setup {
    signs = {
    add          = {hl = 'GitSignsAdd'   , text = '', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeNr'},
  },
  attach_to_untracked = false
}
EOF

" Change the default blue background for diffChange to the background of SignColumn
exec 'hi diffChange ctermfg=' . synIDattr(hlID('diffChange'), 'bg') . ' ctermbg=' . synIDattr(hlID('SignColumn'), 'bg')
""" }}} gitsigns


""" {{{ nvim-dep
highlight DebugBreakpointHl ctermfg=red
highlight DebugStoppedHl ctermfg=green
highlight DebugBreakpointCondHl ctermfg=yellow

lua <<EOF
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.5, -- Can be float or integer > 1
      },
      { id = "watches", size = 00.5 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {},
  --   elements = { "repl" },
  --   size = 10,
  --   position = "right", -- Can be "left", "right", "top", "bottom"
  -- },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})
require('dap-go').setup()
require('dap-python').setup('python3')
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {text='', texthl='DebugBreakpointHl', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='DebugStoppedHl', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DebugBreakpointCondHl', linehl='', numhl=''})
EOF

function! RestartDapSession()
    lua require'dap'.disconnect({restart=true, terminateDebuggee=null})
    lua require'dap'.run_last()
endfunction

function! DisconnectDapSession()
    lua require'dap'.disconnect()
    lua require'dapui'.close()
endfunction

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>r :call RestartDapSession()<CR>
nnoremap <silent> <leader>q :call DisconnectDapSession()<CR>
""" }}} nvim-dap


""" {{{ Telescope.nvim
lua <<EOF
require('nvim-web-devicons').setup()
require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
            }
        },
        selection_caret = ' ',
        prompt_prefix = ' ',
    }
})
require('telescope').load_extension('coc')
require('telescope').load_extension('ultisnips')
require('telescope').load_extension('dap')
EOF

nmap <space>ds :Telescope coc document_symbols<CR>
nmap <space>ws :Telescope coc workspace_symbols<CR>
nmap <space>sn :Telescope ultisnips<CR>
nmap <space>r :Telescope coc references<CR>
nmap <space>dap :Telescope dap commands<CR>

""" }}} Telescope.nvim

""" {{{ treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {'c', 'cpp', 'go', 'markdown', 'gomod', 'gowork', 'bash'},

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

""" }}} treesitter
