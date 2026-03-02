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
                                        vesktop
                                        whatsapp-electron
                                        audible-cli
                                ];

                                file = {
                                        ".config/mango".source = ./mango;
                                };
                        };

                        stylix = {
                                enable = true;
                                autoEnable = true;
                                polarity = "dark";
                                base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
                                targets = {
                                        rofi = {
                                                enable = true;
                                                colors.enable = true;
                                        };
                                        ghostty = {
                                                enable = true;
                                                colors.enable = true;
                                        };
                                        yazi = {
                                                enable = true;
                                                colors.enable = true;
                                        };
                                        lazygit = {
                                                enable = true;
                                                colors.enable = true;
                                        };
                                        vesktop = {
                                                enable = true;
                                                colors.enable = true;
                                        };
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
