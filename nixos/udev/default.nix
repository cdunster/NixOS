{ pkgs, ... }: {
  # Enable udev and add custom rules.
  services.udev = {
    enable = true;
    packages =
      let
        createRule = file:
          pkgs.writeTextFile {
            name = builtins.baseNameOf file;
            text = builtins.readFile file;
            destination = "/etc/udev/rules.d/" + builtins.baseNameOf file;
          };
      in
      [
        (createRule ./rules/69-probe-rs.rules)
        (createRule ./rules/90-saleae-logic.rules)
        (createRule ./rules/90-ledger-nano-x.rules)
      ];
  };
}
