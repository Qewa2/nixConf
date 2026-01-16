{ lib, config, pkgs, inputs, ... }:
let
        cfg = config.myConfigs.nvf;
in
{
        options.myConfigs.nvf = {
                enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
        };

        config = lib.mkIf cfg.enable {
                environment.systemPackages =
                        (config.environment.systemPackages or []) ++ [
                                (inputs.nvf.lib.neovimConfiguration {
                                        inherit pkgs;
                                        modules = [ ./nvfConf.nix ];
                                }).neovim
                ];
        };
}
