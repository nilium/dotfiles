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
if exists('g:autoloaded_rebar_complete')
    finish
endif
let g:autoloaded_rebar_complete = 1

" return a list of suggestions
function! rebar#complete#list(arglead, cmdline, cursorpos)
    let argprev = rebar#complete#argprev(a:arglead, a:cmdline, a:cursorpos)
    " Previous arg is an option
    if argprev =~ '^-'
        let opt_val = get(rebar#complete#opts_info(), argprev, 0)
        " Option requires a value
        if type(opt_val) != type(1) || opt_val != 0
            let sug = rebar#complete#eval(opt_val,
                        \a:arglead, a:cmdline, a:cursorpos)
            return sug
        endif
    endif
    " Previous arg is not an option or is an option that doesn't use a value
    " Arglead is a global
    if a:arglead =~ '='
        return rebar#complete#global_list(a:arglead, a:cmdline, a:cursorpos)
    " Arglead could be command or global or option
    else
        return rebar#complete#full_list(a:arglead, a:cmdline, a:cursorpos)
    endif
endfunction

" list suggestions without any restrictions
function! rebar#complete#full_list(arglead, cmdline, cursorpos)
    let cmds = sort(keys(rebar#complete#cmd_info()))
    let globals = rebar#complete#global_list(a:arglead, a:cmdline, a:cursorpos)
    let opts = sort(keys(rebar#complete#opts_info()))
    return cmds + globals + opts
endfunction

" lookup previous argument on cmdline
function! rebar#complete#argprev(arglead, cmdline, cursorpos)
    let before = a:cmdline[0:a:cursorpos-strlen(a:arglead)-1]
    return matchlist(before, '\([^ ]*\)\s*$')[1]
endfunction

" evaluate a value from an information dictionary
function! rebar#complete#eval(Value, arglead, cmdline, cursorpos)
    if type(a:Value) == type([])
        let suggestions = []
        for Elem in a:Value
            if type(Elem) == type('')
                call add(suggestions, Elem)
            elseif type(Elem) == type(function('strlen'))
                call extend(suggestions, Elem())
            elseif Elem != 0
                echomsg 'Invalid Info'
            endif
            " unlet Elem as could be function or string
            unlet Elem
        endfor
        return suggestions
    elseif type(a:Value) == type(function('strlen'))
        return a:Value(a:arglead, a:cmdline, a:cursorpos)
    endif
endfunction

" list suggestions for globals based on commands in cmdline
function! rebar#complete#global_list(arglead, cmdline, cursorpos)
    let suggestions = []
    let cmdinfo = rebar#complete#cmd_info()
    for cmd in rebar#complete#cmds(a:cmdline)
        for [globalkey, Globalvalue] in items(get(cmdinfo, cmd, {}))
        let globalsuggestions = rebar#complete#eval(Globalvalue,
                    \ a:arglead, a:cmdline, a:cursorpos)
            for globalsuggest in globalsuggestions
                let globalsuggest = rebar#complete#global_create(a:arglead,
                            \ globalkey, globalsuggest)
                call add(suggestions, globalsuggest)
            endfor
            unlet Globalvalue
        endfor
    endfor
    let globalinfo = rebar#complete#global_info()
    for [globalkey, Globalvalue] in items(globalinfo)
        let globalsuggestions = rebar#complete#eval(Globalvalue,
                    \ a:arglead, a:cmdline, a:cursorpos)
        for globalsuggest in globalsuggestions
            let globalsuggest = rebar#complete#global_create(a:arglead,
                        \ globalkey, globalsuggest)
            call add(suggestions, globalsuggest)
        endfor
        unlet Globalvalue
    endfor
    return suggestions
endfunction

" list all commands in cmdline
function! rebar#complete#cmds(cmdline)
    let cmds = {}
    let cmdinfo = rebar#complete#cmd_info()
    for cmd in split(a:cmdline, ' ')
        if cmd =~ '^[a-z\-]\+$'
            let cmds[cmd] = 1
        endif
    endfor
    return keys(cmds)
endfunction

" create suggested global from arglead
function! rebar#complete#global_create(arglead, key, value)
    let matches = matchlist(a:arglead,
                \'^\(' . a:key .'=\)\(\(.*,\)[^,]*$\|.*\)')
    " different global or start of global
    if empty(matches)
        return a:key . '=' . a:value
    " (a:key=)(values,)[singlevalue]
    elseif !empty(matches[3])
        return matches[1] . matches[3] . a:value
    " (a:key=)[singlevalue]
    else
        return matches[1] . a:value
    endif
endfunction

" dictionary for globals
function! rebar#complete#global_info()
    return
                \{
                \'apps' :
                    \[
                        \function('rebar#complete#appid'),
                        \function('rebar#complete#apps_list')
                    \],
                \'skip_apps' :
                    \[
                        \function('rebar#complete#appid'),
                        \function('rebar#complete#apps_list')
                    \],
                \'skip_deps' : ['true', 'false']
                \}
endfunction

" dictionary for commands
function! rebar#complete#cmd_info()
    return
                \{
                \'clean' : {},
                \'compile' : {},
                \'escriptize' : {},
                \'create' : {
                    \'template':
                        \[
                            \function('rebar#complete#templates_list'),
                            \function('rebar#complete#templates_builtin')
                        \]
                    \},
                \'create-app' : {'appid': [function('rebar#complete#appid')]},
                \'create-node' : {'nodeid': [function('rebar#complete#appid')]},
                \'list-templates' : {},
                \'doc' : {},
                \'check-deps' : {},
                \'get-deps' : {},
                \'update-deps' : {},
                \'delete-deps' : {},
                \'list-deps' : {},
                \'generate' : {'dump_spec': ['0', '1']},
                \'overlay' : {},
                \'generate-upgrade' : {
                    \ 'previous_release' : [function('rebar#complete#rel_list')]
                    \},
                \'generate-appups' : {
                    \ 'previous_release' : [function('rebar#complete#rel_list')]
                    \},
                \'eunit' : {
                    \ 'suites' : [function('rebar#complete#eunit_suites_list')],
                    \ 'tests' : function('rebar#complete#eunit_tests_list')
                    \},
                \'ct' : {
                    \ 'suites' : [function('rebar#complete#ct_suites_list')],
                    \ 'case' : function('rebar#complete#ct_case_list')
                    \},
                \'qc' : {},
                \'xref' : {},
                \'help' : {},
                \'version' : {}
                \}
endfunction

" dictionary for options
function! rebar#complete#opts_info()
    return
                \{
                \'-h' : 0,
                \'--help' : 0,
                \'-v' : 0,
                \'-vv' : 0,
                \'-vvv' : 0,
                \'--verbose' : ['0', '1', '2', '3'],
                \'-V' : 0,
                \'--version' : 0,
                \'-f' : 0,
                \'--force' : 0,
                \'-D' : [],
                \'-j' : [function('rebar#complete#jobs_list')],
                \'--jobs' : [function('rebar#complete#jobs_list')],
                \'-C' : [function('rebar#complete#config_list')],
                \'--config' : [function('rebar#complete#config_list')],
                \'-p' : 0,
                \'--profile' : 0,
                \'-k' : 0,
                \'--keep-going' : 0
                \}
endfunction

" list \1 in $HOME/.rebar/templates/\(*\).template
function! rebar#complete#templates_list()
    let templates_str = globpath($HOME . '/.rebar/templates/', '*.template')
    let templates = []
    for template in split(templates_str, "\n")
        let matches = matchlist(template, '\([^/]\+\).template$')
        if !empty(matches) && !empty(matches[1])
            call add(templates, matches[1])
        endif
    endfor
    return templates
endfunction

" list built in rebar templates
function! rebar#complete#templates_builtin()
    return
                \[
                \'basicnif', 'ctsuite', 'simpleapp', 'simplefsm',
                \'simplemod', 'simplenode', 'simplesrv'
                \]
endfunction

" Suggest dirname as appid.
function! rebar#complete#appid()
    return [fnamemodify(expand(getcwd()), ":t")]
endfunction

" List possible app names
function! rebar#complete#apps_list()
    let apps = {}
    let patterns = ['apps/*/', 'deps/*/', 'deps/*/apps/*/']
    for pat in patterns
        for dir in split(globpath('.', pat), "\n")
            let app = fnamemodify(dir, ':h:t')
            let apps[app] = 1
        endfor
    endfor
    return sort(keys(apps))
endfunction

" list dirs rel/*/, quote paths requiring escaping.
function! rebar#complete#rel_list()
    let dirs = []
    for dir in split(globpath('.', 'rel/*/'), "\n")
        call add(dirs, '"' . fnameescape(dir) . '"')
    endfor
    return dirs
endfunction

" list all modules matching **/test/\(*\)_tests.erl, then all **/\(.*\).erl
" (open buffers first)
function! rebar#complete#eunit_suites_list()
    let filters = [
                \ ['**/test/*_tests.erl', ':t', '^\(.*\)_tests.erl$'],
                \ ['**/*.erl', ':t', '^\(.*\).erl$']
                \ ]
    return rebar#complete#filesearch(filters)
endfunction

" Search files and create name from match pattern. If buffer exists for file
" it is pushed to front of list.
function! rebar#complete#filesearch(filters)
    let active = []
    let rest = []
    for [globfilter, fnamemod, matchpat] in a:filters
        for filepath in split(globpath('.', globfilter), "\n")
            let filepath = fnamemodify(filepath, fnamemod)
            let matches = matchlist(filepath, matchpat)
            if !empty(matches)
                if bufnr('^' . filepath . '$') != -1
                    call add(active, matches[1])
                else
                    call add(rest, matches[1])
                endif
            endif
        endfor
    endfor
    return active + rest
endfunction

" list all possible functions, listed in suites, if no suites list all
" functions in test/*_tests.erl
function! rebar#complete#eunit_tests_list(arglead, cmdline, cursopos)
    let suites = rebar#complete#suites(a:cmdline)
    let filters = []
    if !empty(suites)
        for suite in suites
            call add(filters,
                        \['**/test/' . suite . '_tests.erl', '', '^\(.*\)$'])
            call add(filters, ['**/' . suite . '.erl', '', '^\(.*\)$'])
        endfor
    else
        call add(filters, ['test/*_tests.erl', '', '^\(.*\)$'])
    endif
    let filepaths = rebar#complete#filesearch(filters)
    return rebar#complete#case_search(filepaths, '.*_test[_]\?$', [])
endfunction

" list all suites listed in command line
function! rebar#complete#suites(cmdline)
    let matches = matchlist(a:cmdline, 'suites=\([^ ]*\)')
    if !empty(matches)
        return split(matches[1], ',')
    else
        return []
    endif
endfunction

" list all modules matching **/\(*\)_SUITE.erl (open buffers first)
function! rebar#complete#ct_suites_list()
    let filters = [['**/*_SUITE.erl', ':t', '^\(.*\)_SUITE.erl$']]
    return rebar#complete#filesearch(filters)
endfunction

" list all possible functions listed in suites. (remove ct functions)
function! rebar#complete#ct_case_list(arglead, cmdline, cursopos)
    let suites = rebar#complete#suites(a:cmdline)
    let filters = []
    if !empty(suites)
        for suite in suites
            call add(filters, ['**/' . suite . '_SUITE.erl', '', '^\(.*\)$'])
        endfor
        let filepaths = rebar#complete#filesearch(filters)
        let exclusions = rebar#complete#ct_fun_exclude()
        return rebar#complete#case_search(filepaths, '.*', exclusions)
    else
        return []
    endif
endfunction

" list function names to exclude from case=
function! rebar#complete#ct_fun_exclude()
    return
                \[
                \'suite',
                \'all',
                \'groups',
                \'init_per_suite',
                \'end_per_suite',
                \'init_per_group',
                \'end_per_group',
                \'init_per_testcase',
                \'end_per_testcase'
                \]
endfunction

" list number 1..16 as possible job count.
function! rebar#complete#jobs_list()
    return
                \ [
                \'1','2','3','4','5','6','7','8','9',
                \'10','11','12','13','14','15','16'
                \]
endfunction

" list all *.config
function! rebar#complete#config_list()
    return split(globpath('.', '*.config'), "\n")
endfunction

" search for function declaration, search in qflist first.
function! rebar#complete#case_search(filepaths, casepat, exclusions)
    let qf_cases = []
    let cases = []
    let qfdict = rebar#complete#qfdict()
    for filepath in a:filepaths
        let bufnr = bufnr(filepath)
        if bufnr(filepath) != -1
            let file_qf_cases = get(qfdict, bufnr, [])
            let file_qf_cases =
                        \rebar#complete#case_filter(file_qf_cases, a:casepat,
                            \a:exclusions)
            call extend(qf_cases, file_qf_cases)
        endif
        let file_cases =
                    \rebar#complete#case_loop(filepath, a:casepat, a:exclusions)
        call extend(cases, file_cases)
    endfor
    return sort(qf_cases) + sort(cases)
endfunction

" search for functions in a file
function! rebar#complete#case_loop(filepath, casepat, exclusions)
    let cases = {}
    try
        for line in readfile(a:filepath, '', 1000)
            let matches = matchlist(line,'^\([a-z][a-zA-Z0-9_]*\|''[^'']*''\)(')
            if !empty(matches) && (index(a:exclusions, matches[1]) == -1)
                if !empty(matchstr(matches[1], a:casepat))
                    let cases[matches[1]] = 1
                endif
            endif
        endfor
    catch
    endtry
    return sort(keys(cases))
endfunction

" filter functions based on exclusion list and patterns to create cases
function! rebar#complete#case_filter(cases, casepat, exclusions)
    if !empty(a:cases) || !empty(a:exclusions)
        return filter(copy(a:cases),
                    \ '((v:val =~ ''' . a:casepat . ''') && ' .
                    \ '(index([''' . join(a:exclusions, ''',''') . '''], ' .
                    \ ' v:val) == -1))')
    else
        return a:cases
    endif
endfunction

" generate a dictionary from qflist containing failures by bufnr
function! rebar#complete#qfdict()
    let qfdict = {}
    for item in getqflist()
        let bufnr = get(item, 'bufnr', -1)
        if bufnr != -1
            let text = get(item, 'text', '')
            let matches = matchlist(text, '^\s*Failed:\s\+\([^/]\+\)/')
            if !empty(matches)
                let cases = get(qfdict, bufnr, [])
                if index(cases, matches[1]) == -1
                    call add(cases, matches[1])
                    let qfdict[bufnr] = cases
                endif
            endif
        endif
    endfor
    return qfdict
endfunction
