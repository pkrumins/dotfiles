" enable nocompatible mode
"
set nocompatible

" leader is \
let mapleader="\\"

" always utf-8
"
set encoding=utf-8

" enable autoindent and plugins
"
filetype indent plugin on

" make vim search all subdirectories
"
set path+=**

" enhance completion menu
"
set wildmenu

" disable mouse
"
set mouse=
set ttymouse=

" make backspace delete everywhere
"
set backspace=indent,eol,start

" show cursor position
"
set ruler

" show partial commands
"
set showcmd

" show line numbers
"
set number

" keep the cursor in the same column when moving
"
set nostartofline

" enable incremental searching and search highlighting
"
set incsearch
set hlsearch

" enable timeout for key mappings
"
set ttimeout
set ttimeoutlen=120

" highlight current line where cursor is
"
set cul

" enable syntax highlighting
"
syntax enable

let g:jellybeans_overrides = {
\    'Normal' : { 'guifg': 'c0c0c0' },
\    'background' : { 'guibg': '000000' },
\}

" set colorscheme to jellybeans
"
colorscheme jellybeans

" set dark background
"
set background=dark

" always show status line
"
set laststatus=2

" configure tabline
"
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')

    if bufmodified
      let s .= '[+] '
    endif
  endfor

  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()

" increase undo levels to 10,000
"
set undolevels=10000

" increase history to 10,000
"
set history=10000

" expand tabs to spaces
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" enable autoindenting
"
set autoindent

" use one space when joining sentences
"
set nojoinspaces

" use a dictionary
"
set dictionary=/usr/share/dict/words

" goyo mappings
"
nnoremap <silent> <Leader>g :Goyo<CR>

" nerdtree mappings
"
function! NERDTreeToggleCurrentFile()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
nnoremap <silent> <Leader>t :call NERDTreeToggleCurrentFile()<CR>

" bufexplorer mappings
"
nnoremap <silent> <Leader>ee :ToggleBufExplorer<CR>
nnoremap <silent> <Leader>eh :BufExplorerHorizontalSplit<CR>
nnoremap <silent> <Leader>ev :BufExplorerVerticalSplit<CR>

" Leader-f opens fzf files
" Leader-b opens fzf buffers
"
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

" Leader-s toggles spell check
"
nnoremap <silent> <Leader>s :set spell!<CR>
inoremap <silent> <Leader>s <ESC>:set spell!<CR>a

" create command ":sudow" that sudo writes the file
"
cnoremap sudow w !sudo tee % >/dev/null

" quick exit with Q
"
nnoremap Q :q<CR>

" make ,, hide syntax highlighting
"
nmap ,, :noh<CR>

" gj, gk, g$, g^, g0 are better j, k, $, ^, 0
"
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap $ g$
nnoremap g$ $
nnoremap ^ g^
nnoremap g^ ^
nnoremap 0 g0
nnoremap g0 0

vnoremap j gj
vnoremap gj j
vnoremap gk k
vnoremap k gk
vnoremap $ g$
vnoremap g$ $
vnoremap ^ g^
vnoremap g^ ^
vnoremap 0 g0
vnoremap g0 0

" make ctrl+s save the current file
"
nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w!<CR>a

" make ctrl+hjkl move between windows
"
nnoremap <C-h> <C-w>h
inoremap <C-h> <ESC><C-w>h
nnoremap <C-j> <C-w>j
inoremap <C-j> <ESC><C-w>j
nnoremap <C-k> <C-w>k
inoremap <C-k> <ESC><C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-l> <ESC><C-w>l

" tab stuff
"
map <C-t><C-n> :tabnew<CR>
map <C-t>n :tabnew<CR>
map <C-t><C-c> :tabclose<CR>
map <C-t>c :tabclose<CR>
map <C-t><C-h> :tabprev<CR>
map <C-t>h :tabprev<CR>
map <C-t><C-l> :tabnext<CR>
map <C-t>l :tabnext<CR>
nmap tn :tabnext<CR>
nmap tl :tabnext<CR>
nmap tp :tabprev<CR>
nmap th :tabprev<CR>
nmap tc :tabclose<CR>
nmap t1 :tabn 1<CR>
nmap t2 :tabn 2<CR>
nmap t3 :tabn 3<CR>
nmap t4 :tabn 4<CR>
nmap t5 :tabn 5<CR>
nmap t6 :tabn 6<CR>
nmap t7 :tabn 7<CR>
nmap t8 :tabn 8<CR>
nmap t9 :tabn 9<CR>
nmap t0 :tabn 10<CR>

" improve undo/redo for Ctrl-u and Ctrl-w
"
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" use very magic and case insensitive search patterns
"
nnoremap / /\v\c
nnoremap ? ?\v\c

" ignore these suffixes in file completion
"
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" hide modified buffers
"
set hidden

" dont increment/decrement octal numbers (via ctrl+a/ctrl+x)
"
set nrformats-=octal

" display entire last line
"
set display=lastline

" visualize wrapped lines with … characters
"
set showbreak=…

" make horizontal scrolling more pleasant
"
set sidescrolloff=5

" customize various invisible symbols
"
set list
set listchars=tab:↦→,trail:␣,extends:»,precedes:«,nbsp:␣

" drop comment symbols when joining lines
"
set formatoptions+=j

" always report the number of changed lines
"
set report=0

" when opening a file, jump to the last cursor position
"
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" configure netrw
"
let g:netrw_liststyle  = 3     " display a file tree
let g:netrw_dirhistmax = 0     " disable netrw history

" configure json plugin
"
let g:vim_json_syntax_conceal = 0

" configure easy-align plugin
"
xmap <leader>ea <Plug>(EasyAlign)
nmap <leader>ea <Plug>(EasyAlign)

" configure bufkill plugin
"
let g:BufKillCreateMappings = 0

" configure gitgutter plugin
"
:set updatetime=250

" zoom function that opens the current buffer in a new tab
" github.com/junegunn/dotfiles/blob/master/vimrc
"
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" automatically run xrdb when .Xresources is edited
"
autocmd BufWritePost ~/.Xresources silent !xrdb %

