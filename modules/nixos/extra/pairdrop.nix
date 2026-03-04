{
        flake.nixosModules.pairdrop = {
                services.pairdrop = {
                        enable = true;
                        port = 3000;
                };

                networking.firewall.allowedTCPPorts = [ 3000 ];
        };
}
