{
  description = "React dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Versiones específicas de Node.js y npm (opcional)
        nodejs = pkgs.nodejs_20;  # Puedes cambiar a nodejs_18, nodejs_20, etc.
        
        # Paquetes globales que quieras instalar
        globalNodePackages = with pkgs; [
          nodejs
          nodePackages.npm
          nodePackages.yarn
          nodePackages.pnpm
        ];
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            globalNodePackages
            
            # Herramientas de desarrollo adicionales
            git
            curl
            wget
            vim
            neovim

            # Para compilación nativa (a veces necesario para algunas dependencias)
            python3
            gcc
            pkg-config
            openssl
          ];

          shellHook = ''
            echo "🚀 React development environment ready!"
            echo "Node.js version: $(node --version)"
            echo "npm version: $(npm --version)"
            
            # Configuración opcional para npm/yarn
            export NODE_ENV=development
            
            # Si usas pnpm, descomenta la línea siguiente:
            # export PNPM_HOME="$HOME/.local/share/pnpm"
            # export PATH="$PNPM_HOME:$PATH"
          '';
        };
      }
    );
}