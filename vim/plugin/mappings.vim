"
" Mappings
"

" Middle mouse
" I.. don't think I've used this in ages? I don't even have a middle mouse
" button right now. Actually confusing to me.
" nnoremap <MiddleMouse> <Esc><LeftMouse>viw
" vnoremap <MiddleMouse> <Esc><LeftMouse>viw
" inoremap <MiddleMouse> <NOP>
" nnoremap <2-MiddleMouse> <Esc><LeftMouse>vaW
" vnoremap <2-MiddleMouse> <Esc><LeftMouse>vaW
" inoremap <2-MiddleMouse> <NOP>
" nnoremap <3-MiddleMouse> <Esc><LeftMouse>vip
" vnoremap <3-MiddleMouse> <Esc><LeftMouse>vip
" inoremap <3-MiddleMouse> <NOP>
" nnoremap <4-MiddleMouse> <NOP>
" vnoremap <4-MiddleMouse> <NOP>
" inoremap <4-MiddleMouse> <NOP>

" Leader to space.
let mapleader = ' '

" fzf
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>r :Tags<CR>
nnoremap <silent> <Leader>p :Commands<CR>
nnoremap <silent> <Leader>g :GFiles<CR>
nnoremap <silent> <Leader>G :GFiles?<CR>

" Formatting
nnoremap <Leader>=i mzvip=`z
nnoremap <Leader>=g mzgg=G`z
nnoremap <Leader>wi mzgqip`z
nnoremap <Leader>wg mzgggqG`z

" Unite stuff
" Disabled for now, but left in case I decide to try it again and need a
" reference point.
" nnoremap <Leader>ko :Unite -start-insert file_rec/async<CR>
" nnoremap <Leader>kf :Unite -start-insert grep<CR>
" nnoremap <Leader>kr :Unite -start-insert register<CR>
" nnoremap <Leader>ks :Unite -start-insert ultisnips<CR>
" nnoremap <Leader>kk :UniteResume<CR>
" nnoremap <Leader>kR <Plug>(unite_restart)

" Clear search.
nnoremap <Leader><Leader> :nohlsearch<CR>:echo ''<CR>

" Leader to comma
let mapleader = ","

" Switch buffers
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bp :bprev<CR>
" Use count to switch buffers. If no count provided or <= zero, use :ls.
" This is weird and unusually useful.
nnoremap <silent> <expr> <Leader>b (v:count > 0 ? ':b'.v:count : ':ls').'<CR>'

" Useful editing mode toggles.
nnoremap <silent> <Leader>sl :set list!<CR>
nnoremap <silent> <Leader>sw :set wrap!<CR>
nnoremap <silent> <Leader>sr :set relativenumber!<CR>

" Move up / down between display lines.
" Do not remap home or end, as those should always refer to the end of line.
" Intended to get slightly more natural editing regardless of wrapping.
"
" hjkl do not get this treatment because it's a crutch.
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
vnoremap <buffer> <silent> <Up>   gk
vnoremap <buffer> <silent> <Down> gj
onoremap <buffer> <silent> <Up>   gk
onoremap <buffer> <silent> <Down> gj

" Imitate Emacs's to-start/end-of-line keys
" No, I don't care that using C-a and C-e isn't idiomatic vim.
inoremap <silent> <C-e> <C-o>$
inoremap <silent> <C-a> <C-o>^
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
onoremap <silent> <C-a> ^
onoremap <silent> <C-e> $
vnoremap <silent> <C-a> ^
vnoremap <silent> <C-e> $

" Esc-Motion
if exists('g:nil_escmotion') && g:nil_escmotion
	inoremap <silent> <Esc>[D <C-o>b
	inoremap <silent> <Esc>[C <C-o>w
	nnoremap <silent> <Esc>[D b
	nnoremap <silent> <Esc>[C w
	vnoremap <silent> <Esc>[D b
	vnoremap <silent> <Esc>[C e
	nnoremap <silent> <Esc>[1;5D <Plug>CamelCaseMotion_b
	nnoremap <silent> <Esc>[1;5C <Plug>CamelCaseMotion_e
	vnoremap <silent> <Esc>[1;5D <Plug>CamelCaseMotion_b
	vnoremap <silent> <Esc>[1;5C <Plug>CamelCaseMotion_e
endif

" TagBar
nmap <silent> <Leader>O :TagbarToggle<CR>

" Gundo
nmap <silent> <Leader>U :GundoToggle<CR>

" YankRing
nnoremap <silent> <Leader>p :YRShow<CR>1b1b1b

" Buffer closing
nnoremap <silent> <Leader>q :Bdelete<CR>

" vim: set ft=vim ts=8 sw=8 tw=79 sts=0 fo=croql noet sta :
