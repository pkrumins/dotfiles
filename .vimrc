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

# increase undo levels to 10,000
#
set undolevels=10000

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
#
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

# tab stuff
#
map <C-t>n :tabnew<CR>
map <C-t>c :tabclose<CR>
nmap tn :tabnext<CR>
nmap tc :tabclose<CR>
nmap tp :tabprev<CR>
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

# use very magic and case insensitive search patterns
#
nnoremap / /\v\c
vnoremap / /\v\c

