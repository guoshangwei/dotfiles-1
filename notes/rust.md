# Rust Toolchain

```bash
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
rustup completions zsh > "$HOMEBREW_PREFIX/share/zsh/site-functions/_rustup"
rustup component add rustfmt-preview clippy-preview rls-preview rust-analysis rust-src
rustup install nightly
rustup component add --toolchain nightly rustfmt-preview clippy-preview rls-preview rust-analysis rust-src
cargo +nightly install racer
```
