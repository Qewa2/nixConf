{ lib, config, ... }:
let
        cfg = config.myConfigs;
in
{
        imports = [
                ./nvf/nvf.nix
        ];

        options.myConfigs = {
                enableAll = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
        };

        config = lib.mkIf cfg.enableAll {
                myConfigs.nvf.enable = lib.mkDefault true;
        };
}
