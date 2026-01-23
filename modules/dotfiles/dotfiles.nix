{ config, lib, ... }:
let
        dotfiles = lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/dotfiles";
        cfg = config.dotfiles;

        niriEnable = cfg.niri.enable || cfg.enableAll;
        mangoEnable = cfg.mango.enable || cfg.enableAll;
        moduleEnable = cfg.enable || cfg.enableAll;
in
{
        options.dotfiles = {
                enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
                
                enableAll = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };

                niri.enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
                
                mango.enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
        };
        
        config = lib.mkIf moduleEnable (lib.mkMerge [
                (lib.mkIf niriEnable {
                        environment.etc = {
                                "niri".source = "${dotfiles}/niri";
                        };
                        programs.niri.enable = lib.mkDefault true;
                })

                (lib.mkIf mangoEnable {
                        environment.etc = {
                                "mango".source = "${dotfiles}/mango";
                        };
                        programs.mango.enable = lib.mkDefault true;
                })
        ]);
}
