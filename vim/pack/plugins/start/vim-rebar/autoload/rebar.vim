" Copyright 2013 James Fish
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
if exists('g:autoloaded_rebar')
    finish
endif
let g:autoloaded_rebar = 1

function! rebar#dispatch(bang, args)
    let args = join(a:args)
    let [bangs, rebarargs] = rebar#split_args(args)
    let rebarargs = rebar#hijack(rebarargs)
    let cmd = 'rebar ' . rebarargs
    if exists(':Dispatch') && exists(':Start')
        if strlen(bangs) == 0
            execute 'Dispatch' . a:bang rebar#config_add(cmd)
        else
            let bang = (strlen(bangs) > 1) ? '!' : ''
            execute 'Start' . bang rebar#config_add(cmd)
        endif
    else
        return rebar#compile_command(a:bang, rebarargs)
    endif
endfunction

function! rebar#split_args(args)
    "match leading !'s and the remainder
    return matchlist(a:args, '\(!*\)\(.*\)')[1:2]
endfunction

function! rebar#hijack(args)
    if exists('g:rebar_hijack') && !g:rebar_hijack
        return a:args
    else
        let hijackedargs = a:args
        for [pat, rep] in [['ct', 'vimct'], ['eunit', 'vimeunit']]
            let hijackedargs = substitute(hijackedargs,
                        \ '\(^\|\s\+\)\(' . pat . '\)\(\s\+\|$\)',
                        \ '\1' . rep . '\3', 'g')
        endfor
        return hijackedargs
    endif
endfunction

function! rebar#compile_command(bang, args)
    let compiler_info = rebar#get_compiler_info()
    if &autowrite
        wall
    endif
    try
        execute 'compiler rebar'
        execute 'make' . a:bang a:args
    finally
        call rebar#set_compiler_info(compiler_info)
    endtry
    return ''
endfunction

function! rebar#get_compiler_info()
    return [get(b:, 'current_compiler', ''), &l:makeprg, &l:efm]
endfunction

function! rebar#set_compiler_info(compiler_info)
    let [name, &l:makeprg, &l:efm] = a:compiler_info
    if empty(name)
        unlet! b:current_compiler
    else
        let b:current_compiler = name
    endif
endfunction

function! rebar#complete(arglead, cmdline, cursorpos)
    let [rebar_and_bangs, cmdline] =
                \ matchlist(a:cmdline, '^\([^ ]*\)\(.*\)$')[1:2]
    " cursorpos is on extra bangs, can't offer any completion
    if (a:cursorpos <= strlen(rebar_and_bangs)) || (a:cmdline == cmdline)
        return ''
    else
        let cursorpos = a:cursorpos - strlen(rebar_and_bangs)
        let suggestions = rebar#complete#list(a:arglead, cmdline, cursorpos)
        return join(suggestions, "\n")
    endif
endfunction

function! rebar#config_get()
    if exists('g:rebar_config') && type(g:rebar_config) == type('')
        return copy(g:rebar_config)
    else
        return ''
    endif
endfunction

function! rebar#config_set(rebar_config)
    if type(a:rebar_config) != type('')
        echomsg 'Invalid rebar config'
    elseif empty(a:rebar_config)
        unlet g:rebar_config
    else
        let g:rebar_config = copy(a:rebar_config)
    endif
    return ''
endfunction

function! rebar#config_add(cmd)
    let rebar_config = rebar#config_get()
    if empty(rebar_config)
        return a:cmd
    else
        return a:cmd . ' -C ' . rebar_config
    endif
endfunction
