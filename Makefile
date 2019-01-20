PREFIX    ?= ${HOME}
BIN_DIR   ?= ${PREFIX}/bin

HERE := ${.PARSEDIR}
.ifndef PLATFORM
PLATFORM != uname -s | tr A-Z a-z
.endif

FACTS += PLATFORM PREFIX BIN_DIR

SYMLINK := ln -sf

# All convenience targets (sorted lexically)
CONF_TARGETS += install-git
CONF_TARGETS += install-i3
CONF_TARGETS += install-tmux
CONF_TARGETS += install-vim


.PHONY: help all ${CONF_TARGETS}

help:

# vim
TARGETS += install-vim
HELP_install-vim := Install vim configuration, including bundles

VIM_DIR ?= ${PREFIX}/.vim
FACTS += VIM_DIR

install-vim: ${VIM_DIR}
${VIM_DIR}:  vim
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"


# tmux
TARGETS += install-tmux
HELP_install-tmux := Install tmux configuration

TMUX_CONF ?= ${PREFIX}/.tmux.conf
FACTS += TMUX_CONF

install-tmux: ${TMUX_CONF}
${TMUX_CONF}: tmux/${PLATFORM}.conf
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"


# git
TARGETS += install-git
HELP_install-git := Install git configuration

GIT_CONF ?= ${PREFIX}/.gitconfig
FACTS += GIT_CONF

install-git: ${GIT_CONF}
${GIT_CONF}: git/config
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"


# i3 (window manager)
HELP_install-i3 := Install i3 configuration and scripts
.if ${PLATFORM} == linux
TARGETS += install-i3
.endif

I3_BINARIES += i3-move-to-ws
I3_BINARIES += i3-rename-ws
I3_BINARIES += i3-select-ws

I3_DIR ?= ${PREFIX}/.config/i3
FACTS += I3_DIR

install-i3: ${I3_DIR}/config
${I3_DIR}/config: i3/config
	mkdir -p "${BIN_DIR}" "${I3_DIR}"
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"

.for bin in ${I3_BINARIES}
install-i3: ${BIN_DIR}/${bin}
${BIN_DIR}/${bin}: i3/bin/${bin}
	${SYMLINK} "${>:[1]:tA}" "${.TARGET}"
.endfor


# All platform targets
all: ${TARGETS}

help:
	@echo "Install one or more configs from dotfiles using bmake."
	@echo ""
	@echo "Targets:"
	@echo "  * help: Print this help text (default)"
	@echo "  * all: Install all config for the current platform (${PLATFORM:Q})"
.for target in ${CONF_TARGETS:O}
	@echo "  * ${target:Q}: ${HELP_${target}}"
.endfor
	@echo ""
	@echo "Facts:"
.for fact in ${FACTS:O}
	@echo "  ${fact:Q}=${${fact}:Q}"
.endfor
