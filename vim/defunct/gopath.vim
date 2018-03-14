let s:base_gopath = $GOPATH

func! s:SetGOPATH()
        let $GOPATH = s:base_gopath
        let $GOPATH = substitute(system('gopath'), '^[ \t\n]*\(.\{-}\)[ \t\n]*$', '\1', '')
endfunc

augroup AutoGoPath
au!
au BufEnter *.go call s:SetGOPATH()
augroup END

