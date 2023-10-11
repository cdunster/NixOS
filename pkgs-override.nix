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

  kitty = prev.wrapWithNixGLIntel prev.kitty;

  freecad = prev.wrapWithNixGLIntel prev.freecad;

  bloomrpc = prev.wrapWithNixGLIntel prev.bloomrpc;

  godot_4 = prev.wrapWithNixGLIntel (prev.godot_4.overrideAttrs {
    installPhase = ''
      mkdir -p "$out/bin"
      cp bin/godot.* $out/bin/godot4

      installManPage misc/dist/linux/godot.6

      mkdir -p "$out"/share/{applications,icons/hicolor/scalable/apps}
      cp misc/dist/linux/org.godotengine.Godot.desktop "$out/share/applications/org.godotengine.Godot4.desktop"
      substituteInPlace "$out/share/applications/org.godotengine.Godot4.desktop" \
        --replace "Exec=godot" "Exec=godot4" \
        --replace "Godot Engine" "Godot Engine 4"
      cp icon.svg "$out/share/icons/hicolor/scalable/apps/godot.svg"
      cp icon.png "$out/share/icons/godot.png"
    '';
  });
}
