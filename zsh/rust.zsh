# Rust
if type rustc &>/dev/null; then
  export RUSTPATH="/opt/data/rust"
  export CARGO_HOME="$RUSTPATH/cargo"
  export RUST_HOME="$RUSTPATH/rustup"
  export PATH="$CARGO_HOME/bin:$PATH"
fi

