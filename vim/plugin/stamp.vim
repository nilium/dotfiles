" Stamp
" Maps S (shift+s) to replace the current word under the cursor with whatever's
" in the given (or default) register.
"
" I don't know where I got this from or if I wrote it. It's kind of been a while. I know it is modified from what it
" originally was, though.

function! s:Stamp(reg)
	if a:reg == ""
		let a:reg = v:register
	endif
	execute "let l:v = @" . a:reg
	exec "norm! viw\"" . a:reg . "p"
	execute "let @" . a:reg . " = l:v"
endfunction

command! -register -nargs=? Stamp call s:Stamp("<register>")
nnoremap S :execute ":Stamp ".v:register<CR>
