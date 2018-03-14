" appraise.vim
" Noel Cower
"
" Basic git-appraise commands.

if exists('g:appraise_global')
	finish
endif
" let g:appraise_global = 1

function! s:CloseCommentView(hash, line, file)
	let l:lines = filter(getbufline(bufnr('%'), 1, '$'), 'v:val !~ "^#"')
	let l:lines = join(l:lines, "\n")
	let l:lines = substitute(l:lines, '\v^[\s\n]*(.*)[\s\n]*$', '\1')

	echo 'git appraise comment -f ' . shellescape(a:file) . ' -l ' . shellescape(a:line) . ' -m ' . shellescape(l:lines) . ' ' . shellescape(a:hash)
endfunction

function! s:BootstrapCommentView(hash, line, file)
	setlocal buftype=nowrite bufhidden=hide noswapfile
	autocmd BufDelete <buffer> :call <SID>CloseCommentView(a:line, a:file)
	autocmd BufWriteCmd,FileWriteCmd <buffer> :set nomodified
endfunction

function! s:AppraiseComment()
	if !exists('g:appraise_hash') || strlen(g:appraise_hash) == 0
		echo 'No code review hash is set'
		return
	end
	let l:fp = system("git ls-tree --full-name --name-only HEAD " . shellescape(expand('%')))
	exe split tempname() +:call\ <SID>BootstrapCommentView(g:appraise_hash,\ line('.'),\ l:fp)
endfunction

function! s:OpenReview(message, reviewers)
	let l:msg = input("Message: ")
	" system('git appraise request')
endfunction

command! -nargs=1 GSetReview :let g:appraise_hash = "<args>"
command! -nargs=+ GReview :call <SID>OpenReview(<args>)
command! -nargs=0 GComment :call <SID>AppraiseComment()
