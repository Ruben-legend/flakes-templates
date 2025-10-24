{
  description = "A Collection of Personal Nix Flake Templates";

  outputs = { ... }: {
    templates = {
      java = {
        path = ./templates/java;
        description = "A java template.";
      };

      rust = {
        path = ./templates/rust;
        description = "A rust template.";
      };

    };
  };
}