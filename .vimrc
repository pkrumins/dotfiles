# disable mouse
#
set mouse=
set ttymouse=

# enable incremental searching and search highlighting
#
set incsearch
set hlsearch

# highlight current line where cursor is
#
set cul

# expand tabs to spaces
#
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

# create command ":sudow" that sudo writes the file
#
cnoremap sudow w !sudo tee % >/dev/null

# make ",," hide syntax highlighting
#
nmap ,, :noh<CR>

# make ctrl+s save the current file
#
nmap <C-S> :w<CR>
imap <C-S> <ESC>:w!<CR>a

# make ctrl+hjkl move between windows
map <C+h> <C-w>h
map <C+j> <C-w>j
map <C+k> <C-w>k
map <C+l> <C-w>l

