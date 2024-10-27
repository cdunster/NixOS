{ config, ... }:
let
  cfg = config.hostOptions;
in
{
  programs.bash.enable = builtins.elem "bash" cfg.shells;
}
