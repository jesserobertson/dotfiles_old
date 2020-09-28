#!/usr/bin/env bash

GITHUB="https://github.com"
[[ -z "$PYENV_HOME" ]] && export PYENV_HOME="$HOME/.pyenv"

# Install PyEnv dependencies
sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
	libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

_zsh_pyenv_install() {
	echo "Installing pyenv..."
	git clone "${GITHUB}/pyenv/pyenv.git"            "${PYENV_HOME}"
	git clone "${GITHUB}/pyenv/pyenv-doctor.git"     "${PYENV_HOME}/plugins/pyenv-doctor"
	git clone "${GITHUB}/pyenv/pyenv-installer.git"  "${PYENV_HOME}/plugins/pyenv-installer"
	git clone "${GITHUB}/pyenv/pyenv-update.git"     "${PYENV_HOME}/plugins/pyenv-update"
	git clone "${GITHUB}/pyenv/pyenv-virtualenv.git" "${PYENV_HOME}/plugins/pyenv-virtualenv"
	git clone "${GITHUB}/pyenv/pyenv-which-ext.git"  "${PYENV_HOME}/plugins/pyenv-which-ext"
}

_zsh_pyenv_load() {
	# export PATH
     export PATH="$PYENV_HOME/bin:$PATH"

	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
}

# Install PyEnv
[[ ! -f  "$PYENV_HOME/libexec/pyenv" ]] && _zsh_pyenv_install

# Load PyEnv once installed
if [[ ! -f "$PYENV_HOME/libexec/pyenv" ]]; then
	_zsh_pyenv_load
fi

# Install poetry
_zsh_poetry_install() {
	echo "Installing poetry..."
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
}
[[ ! -f "$POETRY_HOME/bin/poetry" ]] && _zsh_poetry_install
