" Inspiration Credits:
" TheSPrimeagen: https://github.com/awesome-streamers/awesome-streamerrc/tree/master/ThePrimeagen

" Do not try to be VIM compatible
set nocompatible

" Colour Settings
syntax enable " Enable Syntax Highlighting

"Encoding
set encoding=utf-8

" Set Leader Character
let mapleader = " "

" Set backspace
set backspace=indent,eol,start

" Dark Background colours
set background=dark
 
" Check Spelling
set spell spelllang=en_gb
set nospell
" Toggle Spelling Highlighting
nnoremap <silent> <Leader>z :set spell!<CR>

" Disable folding
set nofoldenable

" Show White space
set listchars=eol:$,tab:>\ ,trail:~,extends:>,precedes:<
" Toggle listchars
nnoremap <silent> <Leader>w :set list!<CR>

" Prevent VIM wrapping words
set linebreak

" Turn of file type detection and indentation on
filetype plugin indent on
set autoindent " Auto Indent New Lines
set smartindent " Enable smart indent
set showmatch " Highlights matching [{()}]
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Show Hybrid Line Numbers
set number relativenumber
" Redraw only when required
set lazyredraw
" Highlights matching [{()}]
set showmatch
" Always show at least 4 line above/below the cursor
set scrolloff=4

" Searching
set incsearch " Search the file as characters are entered
set hlsearch " Highlight all matches when searching
set ignorecase " Ignores case when searching
set smartcase " Enable Smart Case Search
set inccommand=nosplit " Show live substitution changes
nnoremap <Leader>h :nohlsearch<CR>

" Auto-complete in Menu
set wildmenu

" Map jj to exit from insert mode.
imap jj <Esc>

" vim-polyglot
" https://github.com/sheerun/vim-polyglot
" let g:polyglot_disabled = ['autoindent', 'cpp-modern', 'cmake', 'docker-compose', 'go', 'javascript', 'jsx', 'markdown', 'nginx', 'protobuf', 'python', 'rust', 'sh', 'typescript']

" Plugin Settings

" Base-16 colorscheme
let base16colorspace=256
colorscheme base16-default-dark

" vim-closetag
" https://github.com/alvan/vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" fzf
" https://github.com/junegunn/fzf.vim

" Open fzf
nnoremap <silent> <Leader>f :Files<CR>
" Uses the_silver_searcher
nnoremap <silent> <Leader>fa :Ag<CR>

" markdown-preservim
" https://github.com/iamcco/markdown-preview.nvim

" Toggle Preview
" Markdown Preview
nmap <Leader>pm <Plug>MarkdownPreviewToggle
" Latex Preview
nnoremap <silent> <Leader>pl :AsyncRun latexmk -pvc -pdf %<CR>

" coc.nvim
"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" NerdTree
" https://github.com/preservim/nerdtree

" Open NerdTree on Ctrl-n
map <Leader>n :NERDTreeToggle<CR>
" Close vim if only NerdTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimspector

fun! GotoWindow(id)
  call win_gotoid(a:id)
  MaximizerToggle
endfun

" remaps
nnoremap <Leader>m :MaximizerToggle!<CR>
nnoremap <Leader>d :call vimspector#Launch()<CR>
nnoremap <Leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <Leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <Leader>dw :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <Leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <Leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>

nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver
nmap <Leader>dk <Plug>VimspectorStepOut
nmap <Leader>d_ <Plug>VimspectorRestart
nnoremap <Leader>d<space> :call vimspector#Continue()<CR>

nmap <Leader>dr <Plug>VimspectorRunToCursor
nmap <Leader>db <Plug>VimspectorToggleBreakpoint
nmap <Leader>dbc <Plug>VimspectorToggleConditionalBreakpoint

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

