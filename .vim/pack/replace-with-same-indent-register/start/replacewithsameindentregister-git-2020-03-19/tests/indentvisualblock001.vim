" Test indent-replacing a blockwise selection.

call vimtest#StartTap()
call vimtap#Plan(1)

execute "normal! 4G02w\<C-v>l2ej"
call vimtap#err#Errors('Indent-replace works only with lines', 'normal "agR', 'error with characterwise register')

call vimtest#SaveOut()
call vimtest#Quit()
