{
  inputs,
  self,
  ...
}:
{
  flake-file.inputs = {
    actions-nix = {
      url = "github:nialov/actions.nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
      };
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nix-auto-ci = {
      url = "github:aigis-llm/nix-auto-ci";
      inputs = {
        actions-nix.follows = "actions-nix";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  imports = [
    inputs.git-hooks.flakeModule
    inputs.actions-nix.flakeModules.default
    inputs.nix-auto-ci.flakeModule
  ];

  flake.actions-nix = {
    defaults.jobs = {
      runs-on = "ubuntu-latest";
      timeout-minutes = 60;
    };
    workflows = {
      ".github/workflows/nix-x86_64-linux.yaml" = inputs.nix-auto-ci.lib.makeNixGithubAction {
        flake = self;
        useLix = true;
      };
      ".github/workflows/push-doc-site.yaml" = {
        jobs.push-doc-site = {
          name = "Push docs site";
          steps = [
            {
              uses = "actions/checkout@v4";
            }
            {
              uses = "determinatesystems/nix-installer-action@v20";
              "with" = {
                determinate = false;
                diagnostic-endpoint = "";
                logger = "pretty";
                source-url = "https://install.lix.systems/lix/lix-installer-x86_64-linux";
              };
            }
            {
              uses = "DeterminateSystems/magic-nix-cache-action@main";
              "with".diagnostic-endpoint = "";
            }
            {
              name = "Build the docs website";
              run = ''
                nix build .#docs
                mkdir result-copied
                cp -r result/* result-copied
                touch result-copied/.nojekyll
              '';
            }
            {
              env.API_TOKEN_GITHUB = "\${{ secrets.WEBSITE_DEPLOY }}";
              name = "Push the docs";
              # Songmu's fork is broken
              uses = "cpina/github-action-push-to-another-repository@main";
              "with" = {
                commit-message = "Generated docs from ORIGIN_COMMIT";
                destination-github-username = "firefox-extensions-declarative";
                destination-repository-name = "firefox-extensions-declarative.github.io";
                source-directory = "result-copied";
              };
            }
          ];
        };
        name = "Push docs site";
        on.push.branches = [ "main" ];
      };
    };
  };
}
