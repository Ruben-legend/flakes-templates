{
  description = "A Collection of Personal Nix Flake Templates";

  outputs = { self, ... }: {
    templates = {
      java = {
        path = ./templates/java;
        description = "A java template.";
      };

      rust = {
        path = ./templates/rust;
        description = "A rust template.";
      };

      defaultTemplate = self.rust;
    };
  };
}