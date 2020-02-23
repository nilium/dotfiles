" Hard tabs, width 8, wrap comments at 100 columns
set noexpandtab ts=8 sw=8 sts=8 tw=80

let s:templeader = mapleader
let mapleader = ' '

nnoremap <buffer> <Leader>f :GoImports<CR>
nnoremap <buffer> <Leader>b :GoBuild<CR>
nnoremap <buffer> <Leader>t :GoTest<CR>
nnoremap <buffer> <Leader>v :GoVet<CR>
nnoremap <buffer> <Leader>l :GoLint<CR>
nnoremap <buffer> <Leader><Leader> :GoDoc<CR>


let b:syntastic_mode = 'passive'
let b:sleuth_automatic = 0

let mapleader = s:templeader
