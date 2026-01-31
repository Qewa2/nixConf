{ config, lib, pkgs, ... }:
let
        dotfiles = ./.;
        cfg = config.dotfiles;

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

                mango.enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
        };
        
        config = lib.mkIf moduleEnable (lib.mkMerge [
                (lib.mkIf mangoEnable {
                        environment = {
                                etc = {
                                "mango".source = "${dotfiles}/mango";
                                };
                                
                                systemPackages = with pkgs; [
                                        ghostty
                                ];
                        };
                        programs.mango.enable = lib.mkDefault true;
                })
        ]);
}
