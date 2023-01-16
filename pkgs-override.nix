final: prev: {
  # This override is needed because:
  # 1. From v0.32.0 the config format was changed to KDL which is not yet supported by Nix/home-manager.
  # 2. Recent version seem to lag on startup querying for colour and pixel size.
  zellij = with final; rustPlatform.buildRustPackage rec {
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

  gnome-user-themes-v49 = prev.gnomeExtensions.user-themes.override {
    version = "49";
    sha256 = "0ykaw2602iixn87fc65h6vwxzlcjidpp9hpcsmf66r0f6xibgpah";
  };

  kitty = final.writeShellScriptBin "kitty" ''
    ${prev.nixgl.nixGLIntel}/bin/nixGLIntel ${prev.kitty}/bin/kitty
  '';
}
