PREFIX    ?= ${HOME}
TMUX_CONF ?= ${PREFIX}/.tmux.conf
GIT_CONF  ?= ${PREFIX}/.gitconfig
VIM_DIR   ?= ${PREFIX}/.vim

HERE := ${.PARSEDIR}
.ifndef PLATFORM
PLATFORM != uname -s | tr A-Z a-z
.endif

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
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"

${TMUX_CONF}: tmux/${PLATFORM}.conf
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"

${GIT_CONF}: git/config
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"
