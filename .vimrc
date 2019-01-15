# disable mouse
#
set mouse=
set ttymouse=

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

