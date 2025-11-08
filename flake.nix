{
  description = "A Collection of Personal Nix Flake Templates";

  outputs = { self }: {
    templates = {
      java = {
        path = ./templates/java;
        description = "Java flake template.";
      };
      rust = {
        path = ./templates/rust;
        description = "Rust flake template.";
      };
    };
  };
}
