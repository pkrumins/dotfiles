" Test indent-replacing a characterwise selection.

call vimtest#StartTap()
call vimtap#Plan(1)

normal! 15G0)v$
call vimtap#err#Errors('Indent-replace works only with lines', 'normal "agR', 'error with characterwise register')

call vimtest#SaveOut()
call vimtest#Quit()
