final: prev: {
  # This override is needed because:
  # 1. From v0.32.0 the config format was changed to KDL which is not yet supported by Nix/home-manager.
  # 2. Recent version seem to lag on startup querying for colour and pixel size.
  zellij = prev.rustPlatform.buildRustPackage rec {
    pname = "zellij";
    version = "0.31.4";

    src = prev.fetchFromGitHub {
      owner = "zellij-org";
      repo = "zellij";
      rev = "v${version}";
      sha256 = "sha256-eULdBwQNquk4jj1SjdMsAN7S7mBSZs7jVAwMyFvOlWk=";
    };

    cargoSha256 = "sha256-bKOY1r5SxAI9D+9YkYhX2l+pm2kZ6GEU2cf5NFqhuSU=";

    nativeBuildInputs = with prev; [
      mandown
      installShellFiles
      pkg-config
    ];

    buildInputs = with prev; [
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

    passthru.tests.version = prev.testers.testVersion { package = prev.zellij; };
  };

  # This override is required because Pop!_OS 22.04 uses GNOME 42.5
  gnome-user-themes-v49 = prev.gnomeExtensions.user-themes.override {
    version = "49";
    sha256 = "0ykaw2602iixn87fc65h6vwxzlcjidpp9hpcsmf66r0f6xibgpah";
  };

  # This override is required because Pop!_OS 22.04 uses GNOME 42.5
  gnome-auto-move-windows-v49 = prev.gnomeExtensions.auto-move-windows.override {
    version = "49";
    sha256 = "031ppsjqv3y81wcjjsm14rqfh0l7vvaavy01hlqfyglpk8vlfvml";
  };

  # This override is required for Kitty to work with OpenGL
  kitty = prev.wrapWithNixGLIntel prev.kitty;

  # This override is required for FreeCAD to work with OpenGL
  freecad = prev.wrapWithNixGLIntel prev.freecad;
}
