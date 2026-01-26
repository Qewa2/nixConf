{ lib, config, ... }:
let
        cfg = config.sysConf.sysSound;
in
{
        options = {
                sysConf.sysSound = {
                        enable = lib.mkOption {
                                type = lib.types.bool;
                                default = false;
                        };
                };
        };

        config = lib.mkIf cfg.enable {
                security.rtkit.enable = lib.mkDefault true;
                services = {
                        pulseaudio.enable = lib.mkForce false;
                        pipewire = {
                                enable = lib.mkDefault true;
                                alsa = {
                                        enable = lib.mkDefault true;
                                        support32Bit = lib.mkDefault true;
                                };
                                pulse.enable = lib.mkDefault true;
                                jack.enable = lib.mkDefault true;
                        };
                };
        };
}
