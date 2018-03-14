" Vim color file
"
" Quiet. Black and white.
" Quiet color scheme by Noel Cower.
"
" File:         quiet.vim
" URL:          ???
" Scripts URL:  ???
" Maintainer:   ???
" Version:      ???
" Last Change:  2016 November 2
" License:      MIT
" Contributors: Daniel Herbert (pocketninja)
"               Henry So, Jr. <henryso@panix.com>
"               David Liang <bmdavll at gmail dot com>
"               Rich Healey (richo)
"               Andrew Wong (w0ng)
"               Noel Cower (nilium)
"
" Copyright (c) 2009-2012, 2015 NanoTech
"
" Permission is hereby granted, free of charge, to any per‐
" son obtaining a copy of this software and associated doc‐
" umentation  files  (the “Software”), to deal in the Soft‐
" ware without restriction,  including  without  limitation
" the rights to use, copy, modify, merge, publish, distrib‐
" ute, sublicense, and/or sell copies of the Software,  and
" to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice  and  this  permission  notice
" shall  be  included in all copies or substantial portions
" of the Software.
"
" THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
" KIND,  EXPRESS  OR  IMPLIED, INCLUDING BUT NOT LIMITED TO
" THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICU‐
" LAR  PURPOSE  AND  NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE  LIABLE  FOR  ANY  CLAIM,
" DAMAGES  OR OTHER LIABILITY, WHETHER IN AN ACTION OF CON‐
" TRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON‐
" NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "quietjelly"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  let s:low_color = 0
else
  let s:low_color = 1
endif

" Color approximation functions by Henry So, Jr. and David Liang {{{
" Added to jellybeans.vim by Daniel Herbert

" returns an approximate grey index for the given grey level
fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual grey level represented by the grey index
fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" returns the palette index for the given grey index
fun! s:grey_color(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" returns an approximate color index for the given color level
fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual color level for the given color index
fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" returns the palette index for the given R/G/B color indices
fun! s:rgb_color(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r, g, b)
  " get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " get the closest color
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return s:grey_color(l:gx)
    else
      " use the color
      return s:rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x, l:y, l:z)
  endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
  return s:color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun! s:X(group, fg, bg, attr, lcfg, lcbg)
  if s:low_color
    let l:fge = empty(a:lcfg)
    let l:bge = empty(a:lcbg)

    if !l:fge && !l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=".a:lcbg
    elseif !l:fge && l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." ctermfg=NONE ctermbg=".a:lcbg
    endif
  else
    let l:fge = empty(a:fg)
    let l:bge = empty(a:bg)

    if !l:fge && !l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=#".a:bg." ctermfg=".s:rgb(a:fg)." ctermbg=".s:rgb(a:bg)
    elseif !l:fge && l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=NONE ctermfg=".s:rgb(a:fg)." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." guifg=NONE guibg=#".a:bg." ctermfg=NONE ctermbg=".s:rgb(a:bg)
    endif
  endif

  if a:attr == ""
    exec "hi ".a:group." gui=none cterm=none"
  else
    let l:noitalic = join(filter(split(a:attr, ","), "v:val !=? 'italic'"), ",")
    if empty(l:noitalic)
      let l:noitalic = "none"
    endif
    exec "hi ".a:group." gui=".a:attr." cterm=".l:noitalic
  endif
endfun
" }}}

let g:quietjelly_background_color = "171719"
let g:quietjelly_foreground_color="F0F0F0"

" Other color classes
let g:quietjelly_c_comment="747474"
let g:quietjelly_c_type="FBFBFB"
let g:quietjelly_c_func="FBFBFB"
let g:quietjelly_c_func_name="FBFBFB"
let g:quietjelly_c_call="BBBBBB"
let g:quietjelly_c_namespace="FBFBFB"
let g:quietjelly_c_operator="D3D3D3"
let g:quietjelly_c_keyword="E5E5E5"
let g:quietjelly_c_control="DBDBDB"
let g:quietjelly_c_import="E1E1E1"
let g:quietjelly_c_storage="ECECEC"
let g:quietjelly_c_number="CCCCCC"
let g:quietjelly_c_quote="FFFFFF"
let g:quietjelly_c_string="E1E1E1"
let g:quietjelly_c_interp="E6E6E6"
let g:quietjelly_c_var="E8E8E8"
let g:quietjelly_c_const="D9D9D9"
let g:quietjelly_c_lib_func="EFEFEF"
let g:quietjelly_c_lib_type="E9E9E9"
let g:quietjelly_c_lib_const="CCCCCC"
let g:quietjelly_c_highlight="484848"

call s:X("Normal",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("Constant",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("Number",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("Identifier",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("Statement",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("PreProc",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
call s:X("Type",g:quietjelly_foreground_color,g:quietjelly_background_color,"","White","")
set background=dark

if !exists("g:quietjelly_use_lowcolor_black") || g:quietjelly_use_lowcolor_black
    let s:termBlack = "Black"
else
    let s:termBlack = "Grey"
endif

if version >= 700
  call s:X("CursorLine","",g:quietjelly_c_highlight,"","",s:termBlack)
  call s:X("CursorColumn","",g:quietjelly_c_highlight,"","",s:termBlack)
  call s:X("MatchParen","F2E049","","underline","Yellow","")

  call s:X("TabLine","000000","b8b8b8","none","",s:termBlack)
  call s:X("TabLineFill","989898","","","",s:termBlack)
  call s:X("TabLineSel","000000","f0f0f0","none",s:termBlack,"White")

  " Auto-completion
  call s:X("Pmenu",g:quietjelly_foreground_color,"606060","","White",s:termBlack)
  call s:X("PmenuSel",g:quietjelly_background_color,"eeeeee","",s:termBlack,"White")
endif


call s:X("Visual","","344E6D","none","","DarkCyan")
call s:X("VisualNOS","","344E6D","none","","DarkCyan")
call s:X("Cursor",g:quietjelly_background_color,"33DDFF","",s:termBlack,"LightCyan")
call s:X("LineNr","FDFDFD",g:quietjelly_background_color,"none",s:termBlack,"")

call s:X("CursorLineNr","3aafe0","","none","DarkCyan","")
" Color test for comment
call s:X("Comment","7F7F7F","","none","Grey","")
" TODO: Color test for todo
call s:X("Todo","FFFFFF","","none","White",s:termBlack)

call s:X("StatusLine",g:quietjelly_background_color,"3EB2FC","none","","White")
call s:X("StatusLineNC","757575","212121","none","Grey","DarkGrey")
call s:X("VertSplit","","a6a6a6","",s:termBlack,s:termBlack)
call s:X("WildMenu","f0a0c0","302028","","Magenta","")

call s:X("Folded","a0a8b0","384048","none",s:termBlack,"")
call s:X("FoldColumn","535D66","1f1f1f","","",s:termBlack)
call s:X("SignColumn","404040","","","",s:termBlack)
call s:X("ColorColumn","","222222","","",s:termBlack)

call s:X("Special","FFFFFF","","","White","")

call s:X("String","FCFCFC","","","Green","")
call s:X("StringDelimiter","FFFFFF","","","LightRed","")
call s:X("SpecialChar","FDFDFD","","","LightMagenta","")

call s:X("NonText","555E4F","","","Grey","")
call s:X("SpecialKey","444444","1c1c1c","",s:termBlack,"")
call s:X("Search","DFDFDF","5F00FF","none","White","DarkCyan")

call s:X("ErrorMsg","","902020","","","DarkRed")
hi! link Error ErrorMsg
hi! link MoreMsg Special
call s:X("Question","65C254","","","Green","")


" Spell Checking

call s:X("SpellBad","","902020","underline","","DarkRed")
call s:X("SpellCap","","0000df","underline","","Blue")
call s:X("SpellRare","","540063","underline","","DarkMagenta")
call s:X("SpellLocal","","2D7067","underline","","Green")

" VimDiff

call s:X("DiffAdd","D2EBBE","437019","","White","DarkGreen")
call s:X("DiffDelete","40000A","700009","","DarkRed","DarkRed")
call s:X("DiffChange","","2B5B77","","White","DarkBlue")
call s:X("DiffText","8fbfdc","000000","reverse","Yellow","")

" Diff

hi! link diffRemoved DiffDelete
hi! link diffAdded DiffAdd


augroup quietjellyPHP
au!
au FileType php call <SID>OverridePHPSyntax()
augroup END

" vim-indent-guides

if !exists("g:indent_guides_auto_colors")
  let g:indent_guides_auto_colors = 0
endif
call s:X("IndentGuidesOdd","","1d1d1d","","","")
call s:X("IndentGuidesEven","","181818","","","")

" Plugins, etc.

hi! link TagListFileName Directory
call s:X("PreciseJumpTarget","B9ED67","405026","","White","Green")

let g:quietjelly_background_color_256=233
" Manual overrides for 256-color terminals. Dark colors auto-map badly.
" TODO: Port from jellybeans
" if !s:low_color
"   hi Search ctermbg=57 ctermfg=188
"   hi StatusLineNC ctermbg=232 ctermfg=244
"   hi Folded ctermbg=235
"   hi FoldColumn ctermbg=235
"   hi CursorColumn ctermbg=234
"   hi ColorColumn ctermbg=234
"   hi CursorLine ctermbg=234
"   hi CursorLineNr ctermbg=234
"   hi SpecialKey ctermbg=234
"   exec "hi NonText ctermbg=".g:quietjelly_background_color_256." ctermfg=236"
"   exec "hi LineNr ctermbg=".g:quietjelly_background_color_256
"   exec "hi SignColumn ctermbg=".g:quietjelly_background_color_256
"   hi DiffText ctermfg=75
"   exec "hi Normal ctermbg=".g:quietjelly_background_color_256
"   hi DbgBreakPt ctermbg=26
"   hi IndentGuidesOdd ctermbg=234
"   hi IndentGuidesEven ctermbg=235
" endif

hi UnderWord term=underline cterm=underline gui=underline

if exists("g:quietjelly_overrides")
  fun! s:load_colors(defs)
    for [l:group, l:v] in items(a:defs)
      call s:X(l:group, get(l:v, 'guifg', ''), get(l:v, 'guibg', ''),
      \                 get(l:v, 'attr', ''),
      \                 get(l:v, 'ctermfg', ''), get(l:v, 'ctermbg', ''))
      if !s:low_color
        for l:prop in ['ctermfg', 'ctermbg']
          let l:override_key = '256'.l:prop
          if has_key(l:v, l:override_key)
            exec "hi ".l:group." ".l:prop."=".l:v[l:override_key]
          endif
        endfor
      endif
      unlet l:group
      unlet l:v
    endfor
  endfun
  call s:load_colors(g:quietjelly_overrides)
  delf s:load_colors
endif

"hi Visual term=none cterm=none ctermbg=23 guibg=#344E6D gui=none

" delete functions {{{
delf s:X
delf s:rgb
delf s:color
delf s:rgb_color
delf s:rgb_level
delf s:rgb_number
delf s:grey_color
delf s:grey_level
delf s:grey_number
" }}}
