{
        flake.nixosModules.extra.ssh = {
                programs.gnupg = {
                        enable = true;
                        enableSSHSupport = true;
                };

                services.openssh.enable = true;
                networking.firewall.allowedTCPPorts = [ 22 ];
        };
}
