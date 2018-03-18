_         :=
PREFIX    ?= ${HOME}
TMUX_CONF ?= ${PREFIX}/.tmux.conf
GIT_CONF  ?= ${PREFIX}/.gitconfig
VIM_DIR   ?= ${PREFIX}/.vim

HERE := ${.PARSEDIR}
PLATFORM ?= ${_:!uname -s!:tl}

GMAKE   ?= ${_:!((hash gmake && which gmake) || (hash make && which make)) 2>/dev/null!}
SYMLINK := ln -sf

TARGETS := \
	install-tmux \
	install-vim \
	install-git

.PHONY: all ${TARGETS}

all: ${TARGETS}

install-tmux: ${TMUX_CONF}
install-vim: ${VIM_DIR}
install-git: ${GIT_CONF}

${VIM_DIR}:  vim
	cd vim/bundle/vimproc.vim && "${GMAKE}"
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"

${TMUX_CONF}: tmux/${PLATFORM}.conf
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"

${GIT_CONF}: git/config
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"
