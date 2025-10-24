{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
        # Rust toolchain
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
        
        # Rust development dependencies
        rust-dependencies = with pkgs; [
          rustc
          cargo
          rustfmt # Optional: for formatting
          clippy  # Optional: for linting
          rust-analyzer # Optional: for language server
        ];
        
      in
      {
        # Development shells
        devShells.default = pkgs.mkShell {
          buildInputs = rust-dependencies;
          
          # Environment variables
          RUST_BACKTRACE = "full";
          RUST_LOG = "debug";
          
          # For native dependencies
          nativeBuildInputs = with pkgs; [ pkg-config ];
          
          # For openssl
          OPENSSL_NO_VENDOR = "1";
          OPENSSL_DIR = "${pkgs.openssl.dev}";
          OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
          RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
          
          shellHook = ''
            echo "🦀 Rust development environment"
            echo "Rust version: $(rustc --version)"
            echo "Cargo version: $(cargo --version)"
            echo ""
            echo "Available commands:"
            echo "  cargo build    - Build the project"
            echo "  cargo run      - Run the project"
            echo "  cargo test     - Run tests"
            echo "  cargo watch    - Watch for changes"
            echo "  cargo clippy   - Run linter"
            echo "  cargo fmt      - Format code"
            echo ""
          '';
        };

        # Minimal shell for quick work
        devShells.minimal = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            cargo-edit
            cargo-watch
            git
          ];
          
          shellHook = ''
            echo "🦀 Minimal Rust environment"
          '';
        };

        # Shell with nightly Rust
        devShells.nightly = pkgs.mkShell {
          buildInputs = with pkgs; [
            (rust-bin.nightly.latest.default.override {
              extensions = [ "rust-src" "rust-analyzer" ];
            })
            cargo-edit
            cargo-watch
            git
          ];
        };

        # Shell for WebAssembly development
        devShells.wasm = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustToolchain
            wasm-pack
            binaryen
            wabt
            nodejs
            cargo-generate
          ];
          
          shellHook = ''
            echo "🦀 Rust + WebAssembly environment"
            echo "wasm-pack version: $(wasm-pack --version)"
          '';
        };
      }
    );
}