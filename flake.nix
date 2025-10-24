{
  description = "A Collection of Personal Nix Flake Templates";

  outputs = { self, ... }:
  let 
    temp = {
      java = {
        path = ./templates/java;
        description = "A java template.";
      };

      rust = {
        path = ./templates/rust;
        description = "A rust template.";
      };
    };
  in {
    templates = temp;
  };
}