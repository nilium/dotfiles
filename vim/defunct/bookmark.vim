" bookmark.vim
" Noel Cower
"
" Adds sign markers to lines and highlights them.

hi BookmarkLine cterm=underline
hi link BookmarkSign Todo

sign define BookmarkLine linehl=BookmarkLine text=^^ texthl=BookmarkSign

function! s:PutBookmark(line, clear)
	if !exists('b:bookmark_num')
		let b:bookmark_num = 20000
		let b:bookmarks = {}
	endif

	let l:buffer = bufnr(expand('%'))
	if has_key(b:bookmarks, a:line)
		let l:bookmark = b:bookmarks[a:line]
		unlet b:bookmarks[a:line]
		execute printf("sign unplace %s buffer=%s", l:bookmark, l:buffer)
		return
	elseif a:clear
		return
	endif

	let b:bookmark_num = b:bookmark_num + 1
	let l:bookmark = b:bookmark_num
	let b:bookmarks[a:line] = l:bookmark
	execute printf("sign place %s line=%s name=BookmarkLine buffer=%s", l:bookmark, a:line, l:buffer)
endfunction

function! s:PutBookmarks(clear) range
	let l:clear = a:clear == '!'
	for l:line in range(a:firstline, a:lastline)
		call <SID>PutBookmark(l:line, l:clear)
	endfor
endfunction

command! -range -bang Bookmark <line1>,<line2>call <SID>PutBookmarks("<bang>")

" vim: set ft=vim ts=8 sw=8 tw=79 sts=0 fo=n1jcroql noet sta :
