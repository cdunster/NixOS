{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixgl, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
          (final: prev: {
            zellij = with pkgs; rustPlatform.buildRustPackage
              rec {
                pname = "zellij";
                version = "0.31.4";

                src = fetchFromGitHub {
                  owner = "zellij-org";
                  repo = "zellij";
                  rev = "v${version}";
                  sha256 = "sha256-eULdBwQNquk4jj1SjdMsAN7S7mBSZs7jVAwMyFvOlWk=";
                };

                cargoSha256 = "sha256-bKOY1r5SxAI9D+9YkYhX2l+pm2kZ6GEU2cf5NFqhuSU=";

                nativeBuildInputs = [
                  mandown
                  installShellFiles
                  pkg-config
                ];

                buildInputs = [
                  openssl
                ] ++ lib.optionals stdenv.isDarwin [
                  libiconv
                  DiskArbitration
                  Foundation
                ];

                preCheck = ''
                  HOME=$TMPDIR
                '';

                postInstall = ''
                  mandown docs/MANPAGE.md > zellij.1
                  installManPage zellij.1
                  installShellCompletion --cmd $pname \
                    --bash <($out/bin/zellij setup --generate-completion bash) \
                    --fish <($out/bin/zellij setup --generate-completion fish) \
                    --zsh <($out/bin/zellij setup --generate-completion zsh)
                '';

                passthru.tests.version = testers.testVersion { package = zellij; };
              };
          })
        ];
      };
    in
    {
      nixosConfigurations.MiNixOS = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.callum = import ./home.nix;
            home-manager.extraSpecialArgs = attrs;
          }
        ];
      };

      homeConfigurations.callum = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = attrs;
        modules = [
          {
            home = {
              username = "Callum";
              homeDirectory = "/home/callum";
            };
          }
          {
            targets.genericLinux.enable = true;
          }
          ./home.nix
        ];
      };
    };
}
