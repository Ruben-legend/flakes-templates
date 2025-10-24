{
  outputs = {...}: {
    templates.simple = {
      description = "A simple flake";
      path = ./templates/java;
      welcomeText = ''
        Welcome to Nix!

        This flake exports a single package, `hello`, which can be
        executed by running:

        $ nix run #.hello

        Check out my article series on Nix for more information!
        https://dev.to/arnu515/my-new-nix-series-2cc3
      '';
    };
  };
}