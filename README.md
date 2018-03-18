vim-rebar
=========
A vim plugin to make using rebar easier and faster from inside vim.

Features
--------
- Asynchronous

- Quickfix

- Command completion

Install
-------
- Install `dispatch.vim` (https://github.com/tpope/vim-dispatch)

- Install `rebar_vim_plugin` (https://github.com/fishcakez/rebar_vim_plugin)

- Clone this repo into your vim-path. With pathogen.vim would be:

```
cd ~/.vim/bundle && git clone https://github.com/fishcakez/vim-rebar.git
```

Usage
-----
Exactly the same as `rebar`; to run `rebar compile`:
```
:Rebar compile
```
Or in the background
```
:Rebar! compile
```
Then to create quickfix list:
```
:Copen
```
Or to view all the output in a quickfix list:
```
:Copen!
```
To run `rebar` in a new, focused, window (no quickfix support):
```
:Rebar!! get-deps
```
To run `rebar` in a new, unfocused, window (no quickfix support):
```
:Rebar!!! ct
```
