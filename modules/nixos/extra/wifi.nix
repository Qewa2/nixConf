{ ... }: {
        flake.nixosModules.wifi = { lib, pkgs, ... }: {
                networking = {
                        hostName = lib.mkDefault "nixos";
                        networkmanager = {
                                enable = true;
                                wifi.backend = "iwd";
                        };
                        wireless.iwd.enable = true;
                };
                systemd.services.iwd.wantedBy = [ "multi-user.target" ];

                environment.systemPackages = with pkgs; [
                        impala
                ];
        };
}
