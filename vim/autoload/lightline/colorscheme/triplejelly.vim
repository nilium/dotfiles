 " =============================================================================
" Filename: autoload/lightline/colorscheme/triplejelly.vim
" Version: 0.0
" Author: itchyny (modified by nilium)
" License: MIT License
" Last Change: 2015/02/07 5:59:07.
" =============================================================================
let s:base03  = [ '#171719', 233 ]
let s:base02  = [ '#171719', 233 ]
let s:base01  = [ '#1c1c1d', 234 ]
let s:base00  = [ '#303031', 236 ]
let s:base0   = [ '#a8a8a9', 248 ]
let s:base1   = [ '#a8a8a9', 248 ]
let s:base2   = [ '#a8a8a9', 248 ]
let s:base3   = [ '#dadada', 253 ]
let s:yellow  = [ '#dfdf00', 184 ]
let s:orange  = [ '#ff8700', 208 ]
let s:red     = [ '#df5f5f', 167 ]
let s:magenta = [ '#df87af', 175 ]
let s:blue    = [ '#00afdf', 38  ]
let s:cyan    = [ '#00dfaf', 43  ]
let s:green   = [ '#5faf00', 70  ]
let s:active  = s:blue

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base01 ], [ s:base0, s:base00 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base01 ], [ s:base0, s:base00 ] ]
let s:p.insert.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:orange ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:yellow ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base3, s:active ] ]
let s:p.inactive.middle = [ [ s:base00, s:base01 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#triplejelly#palette = lightline#colorscheme#flatten(s:p)
