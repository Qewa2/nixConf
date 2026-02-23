{
        flake.nixosModules.ssh = {
                programs.gnupg.agent = {
                        enable = true;
                        enableSSHSupport = true;
                };

                services.openssh.enable = true;
                networking.firewall.allowedTCPPorts = [ 22 ];
        };
}
