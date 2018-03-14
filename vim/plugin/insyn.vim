" I don't remember where exactly I got this, but it appears to be Ivan Tischenko's work, per:
" https://github.com/vim-scripts/T7ko/blob/master/plugin/t7ko/text.vim
"
" I've reproduced the info lines from that below, but this isn't the complete file and should not be treated as such:
"
" File: t7ko/text.vim
" Author: Ivan Tishchenko (t7ko AT mail DOT ru)
" Version: 1.1
" Last Modified: June 11, 2005

function! TextEnableCodeSnip(filetype,start,end,textSnipHl,extra) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ '.a:extra.' contains=@'.group
endfunction

function! s:SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

command! SynItem :echo s:SyntaxItem()

call TextEnableCodeSnip(  'c',   '@begin=c@',   '@end=c@', 'SpecialComment', '')
call TextEnableCodeSnip('cpp', '@begin=cpp@', '@end=cpp@', 'SpecialComment', '')
call TextEnableCodeSnip('sql', '@begin=sql@', '@end=sql@', 'SpecialComment', '')
call TextEnableCodeSnip('lua', '@begin=lua@', '@end=lua@', 'SpecialComment', '')
call TextEnableCodeSnip('lua', '--lua{{',     '--lua}}',   'SpecialComment', '')
