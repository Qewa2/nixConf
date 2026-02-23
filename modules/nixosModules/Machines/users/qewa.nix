{
        flake.nixosModules.qewa = { inputs, pkgs, ... }: {
                imports = [
                        inputs.home-manager.nixosModules.default
                ];
                users.users.qewa = {
                        isNormalUser = true;
                        description = "Qewa";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };
                
                home-manager.users.qewa = { pkgs, ... }: {
                        home = {
                                username = "qewa";
                                homeDirectory = "/home/qewa";
                                stateVersion = "25.11";
                        };

                        programs = {
                                btop = {
                                        enable = true;
                                        settings = {
                                                vim_keys = true;
                                                update_ms = 100;
                                        };
                                };

                                git = {
                                        enable = true;
                                        settings = {
                                                name = "Qewa2";
                                                email = "quinn.schubert@icloud.com";
                                        };
                                        safe.directory = "/etc/nixos";
                                        init.defaultBranch = "main";
                                };
                        };
                };
        };
}
