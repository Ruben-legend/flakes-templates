{
  description = "A Collection of personal nix flake template";

  output = {self, ...}:{
    templates = {
      java = {
        path = ./java;
        description = "This is a template of java";
      };

      rust = {
        path = ./rust;
        description = "this is a template of rust";
      };

    };

  };

}