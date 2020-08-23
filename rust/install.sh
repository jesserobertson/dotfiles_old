echo "Installing Rust language"
curl https://sh.rustup.rs -sSf | sh

# Load up cargo environment to install stuff
source ${HOME}/.cargo/env

## INSTALL EXA
echo "Installing exa, sudo required to install to /usr/local/bin"
cargo install --no-default-features --git https://github.com/ogham/exa