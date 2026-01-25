{ lib, config, ... }:
let
        cfg = config.myConfigs;
in
{
        imports = [
                ./nvf/nvf.nix
                ./lutris/lutris.nix
        ];

        options.myConfigs = {
                enableAll = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
                flake = lib.mkOption {
                        type = lib.types.str;
                        default = "/etc/nixos/#main";
                };
        };

        config = lib.mkIf cfg.enableAll {
                myConfigs.nvf.enable = lib.mkDefault true;
                # myConfigs.lutris.enable = lib.mkDefault true;
        };
}
