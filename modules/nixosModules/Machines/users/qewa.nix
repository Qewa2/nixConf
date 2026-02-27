{
        flake.nixosModules.qewa = { inputs, pkgs, ... }: {
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
                                packages = with pkgs; [
                                        ghostty
                                        cowsay
                                        discord
                                        whatsapp-electron
                                        audible-cli
                                ];

                                file = {
                                        ".config/mango".source = ./mango;
                                };
                        };

                        programs = {
                                home-manager.enable = true;
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
                                                user = {
                                                        name = "Qewa2";
                                                        email = "quinn.schubert@icloud.com";
                                                };

                                                safe.directory = "/etc/nixos";
                                                init.defaultBranch = "main";
                                        };
                                };
                        };
                };
        };
}
