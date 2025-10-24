{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        
        # Rust development dependencies
        java-dependencies = with pkgs; [    
            jdk21
            gradle
            maven
        ];
        
      in
      {
        # Development shells
        devShells.default = pkgs.mkShell {
          buildInputs = java-dependencies;
          
          # For native dependencies
          nativeBuildInputs = with pkgs; [ pkg-config ];
          
          shellHook = ''
            echo "Java development environment ready!"
            java -version
            echo "Gradle version:"
            gradle --version
          '';
        };
      }
    );
}