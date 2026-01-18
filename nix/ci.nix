{
  inputs,
  self,
  ...
}:
{
  flake-file.inputs = {
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };
    actions-nix = {
      url = "github:nialov/actions.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
      };
    };
    nix-auto-ci = {
      url = "github:aigis-llm/nix-auto-ci";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        actions-nix.follows = "actions-nix";
      };
    };
  };

  imports = [
    inputs.git-hooks.flakeModule
    inputs.actions-nix.flakeModules.default
    inputs.nix-auto-ci.flakeModule
  ];

  flake.actions-nix = {
    defaults = {
      jobs = {
        timeout-minutes = 60;
        runs-on = "ubuntu-latest";
      };
    };
    workflows = {
      ".github/workflows/nix-x86_64-linux.yaml" = inputs.nix-auto-ci.lib.makeNixGithubAction {
        flake = self;
        useLix = true;
      };
      ".github/workflows/push-doc-site.yaml" = {
        name = "Push docs site";
        on = {
          push = {
            branches = [ "main" ];
          };
        };
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
                logger = "pretty";
                diagnostic-endpoint = "";
                source-url = "https://install.lix.systems/lix/lix-installer-x86_64-linux";
              };
            }
            {
              uses = "DeterminateSystems/magic-nix-cache-action@main";
              "with" = {
                diagnostic-endpoint = "";
              };
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
              name = "Push the docs";
              # Songmu's fork is broken
              uses = "cpina/github-action-push-to-another-repository@main";
              env = {
                API_TOKEN_GITHUB = "\${{ secrets.WEBSITE_DEPLOY }}";
              };
              "with" = {
                source-directory = "result-copied";
                destination-github-username = "firefox-extensions-declarative";
                destination-repository-name = "firefox-extensions-declarative.github.io";
                commit-message = "Generated docs from ORIGIN_COMMIT";
              };
            }
          ];
        };
      };
    };
  };
}
