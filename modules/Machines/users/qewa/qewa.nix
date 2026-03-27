{ self, ... }: {
        flake.nixosModules.qewa = { pkgs, ... }: {
                users.users.qewa = {
                        isNormalUser = true;
                        description = "Qewa";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };
                
                home-manager.users.qewa = { pkgs, config, ... }: {
                        imports = [
                                self.homeModules.base

                                self.homeModules.btop
                                self.homeModules.cava

                                self.homeModules.styling
                                self.homeModules.development
                        ];

                        home = {
                                username = "qewa";
                                homeDirectory = "/home/qewa";
                                stateVersion = "26.05";
                                packages = with pkgs; [
                                        cowsay
                                        audible-cli
                                        whatsapp-electron
                                        labymod-launcher
                                ];

                                file = {
                                        ".config/mango".source = ./mango;
                                        ".init.sh".text = ''
                                                #!${pkgs.lib.getExe pkgs.bash}
                                                ${pkgs.lib.getExe pkgs.fastfetch}
                                                mango > /dev/null 2>&1
                                                exec ${pkgs.lib.getExe pkgs.bash}
                                        '';
                                };
                        };

                        programs = {
                                kitty.enable = true;
                                vesktop.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                                lazygit.enable = true;

                                git = {
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
