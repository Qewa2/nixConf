{ self, ... }: {
        flake.nixosModules.qewa = { pkgs, ... }: {
                users.users.qewa = {
                        isNormalUser = true;
                        description = "Qewa";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };
                
                home-manager.users.qewa = { pkgs, ... }: {
                        imports = [
                                self.homeManagerModules.base

                                self.homeManagerModules.btop
                        ];

                        home = {
                                username = "qewa";
                                homeDirectory = "/home/qewa";
                                stateVersion = "25.11";
                                packages = with pkgs; [
                                        cowsay
                                        audible-cli
                                        whatsapp-electron
                                ];

                                file = {
                                        ".config/mango".source = ./mango;
                                };
                        };

                        stylix = {
                                enable = true;
                                autoEnable = true;
                                polarity = "dark";
                        };

                        programs = {
                                kitty.enable = true;
                                vesktop.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                                lazygit.enable = true;
                                cava.enable = true;

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
