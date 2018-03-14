" Hard tabs, width 8, wrap comments at 100 columns
set noexpandtab ts=8 sw=8 sts=8 tw=100

let s:templeader = mapleader
let mapleader = ' '

nnoremap <buffer> <Leader>gf :GoFmt<CR>
nnoremap <buffer> <Leader>gi :GoImports<CR>
nnoremap <buffer> <Leader>gI :GoInstall<CR>
nnoremap <buffer> <Leader>gb :GoBuild<CR>
nnoremap <buffer> <Leader>gt :GoTest<CR>
nnoremap <buffer> <Leader>gv :GoVet<CR>
nnoremap <buffer> <Leader>gl :GoLint<CR>
nnoremap <buffer> <Leader>gd :GoDoc<CR>

let b:syntastic_mode = 'passive'

let mapleader = s:templeader
