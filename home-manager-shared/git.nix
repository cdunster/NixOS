{ pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      format = "openpgp";
      signer = "${pkgs.gnupg}/bin/gpg";
      key = null;
      signByDefault = true;
    };
    ignores = [
      "Session.vim"
      ".cache"
      ".direnv"
    ];
    settings = {
      credential.helper = "store";
      init.defaultBranch = "main";
      pull.ff = "only";
      safe.directory = [ "/etc/nixos" ];
      rerere.enabled = true;
      url."ssh://github.com/".pushInsteadOf = "https://github.com/";
    };
  };
}
