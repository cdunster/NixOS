{ pkgs, lib, config, ... }: {
  config =
    let
      cosmicEnabled = config.hostOptions.desktopEnvironments.cosmic.enable;
      tailscaleEnabled = config.hostOptions.tailscale.enable;
      user = config.hostOptions.user;

      gui-scale-applet = pkgs.rustPlatform.buildRustPackage {
        pname = "gui-scale-applet";
        version = "3.10.20";

        src = pkgs.fetchFromGitHub {
          owner = "cosmic-utils";
          repo = "gui-scale-applet";
          rev = "4fbaa94b4afb9f1b4d496e678e10dd5b0147670a";
          hash = "sha256-6xNxDPnju691l8Fs1kcsIsBGZP/OFldKl25uuuS98NI=";
        };

        cargoHash = "sha256-If8vujmsTq5SFENuD+NyatG4cFCuUaORuDswF93bftY=";

        nativeBuildInputs = [ pkgs.libcosmicAppHook ];

        doCheck = false;

        installPhase = ''
          runHook preInstall
          install -Dm755 target/${pkgs.stdenv.hostPlatform.rust.cargoShortTarget}/release/gui-scale-applet -t $out/bin/
          install -Dm644 data/com.bhh32.gui-scale-applet.desktop -t $out/share/applications/
          install -Dm644 data/com.bhh32.gui-scale-applet.metainfo.xml -t $out/share/metainfo/
          install -Dm644 data/icons/scalable/apps/com.bhh32.gui-scale-applet.png -t $out/share/icons/hicolor/scalable/apps/

          # Upstream uses NotShowIn=COSMIC, which hides the entry from COSMIC
          # entirely (including the panel's "Add applet" list) since
          # XDG_CURRENT_DESKTOP=COSMIC. Official COSMIC applets use
          # NoDisplay=true instead, which only hides them from the app
          # launcher while keeping them visible to the applet picker.
          substituteInPlace $out/share/applications/com.bhh32.gui-scale-applet.desktop \
            --replace-fail "NotShowIn=COSMIC;" "NoDisplay=true"

          runHook postInstall
        '';

        meta = with lib; {
          description = "GUI wrapper applet for the Tailscale CLI on the COSMIC desktop";
          homepage = "https://github.com/cosmic-utils/gui-scale-applet";
          license = licenses.bsd3;
          mainProgram = "gui-scale-applet";
          platforms = platforms.linux;
        };
      };
    in
    lib.mkIf (cosmicEnabled && tailscaleEnabled) {
      home-manager.users.${user}.home.packages = [ gui-scale-applet ];
    };
}
