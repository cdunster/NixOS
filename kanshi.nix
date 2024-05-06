{ ... }: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          { criteria = "eDP-1"; }
        ];
      }
      {
        profile.name = "docked-home";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Samsung Electric Company Odyssey G85SB H1AK500000";
          }
        ];
      }
      {
        profile.name = "docked-office";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL S3422DW GW85TH3";
          }
        ];
      }
    ];
  };
}
