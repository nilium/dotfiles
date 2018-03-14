if exists('g:json_format_loaded')
	finish
endif
let g:json_format_loaded = 1

command! -range=% JsonReformat <line1>,<line2>!python -m json.tool

