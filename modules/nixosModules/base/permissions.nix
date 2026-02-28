{ ... }: {
        /*
                This module implements a user grou to witch you can add your user.
                If your user is part of the group you can edit and change the files in /etc/nixos
                without using sudo or needing to use root.
                this also makes sure that you don't need to login to git when pushing your /etc/nixos
                directory
        */
        flake.nixosModules.base = { ... }: {
                users.groups.nixos.gid = 991;
                system.activationScripts.NixOsPermissions = {
                        text = ''
                                chown root:nixos /etc/nixos
                                find /etc/nixos -exec chown root:nixos {} +
                                find /etc/nixos -type d -exec chmod -R 774 {} +
                                find /etc/nixos -type f -exec chmod -R 664 {} +
                        '';
                };

                systemd.tmpfiles.rules = [
                        "d /etc/nixos 0775 root nixos -"
                ];
        };
}
