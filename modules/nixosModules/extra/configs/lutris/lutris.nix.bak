{ pkgs, config, lib, ... }:
let
        cfg = config.myConfigs.lutris;
in
{
        options.myConfigs.lutris = {
                enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
        };

        config = lib.mkIf cfg.enable {
                environment.systemPackages = with pkgs; [
                        lutris
                        protonup-rs
                        protonplus
                        wine
                        winetricks
                ];
        };
}
