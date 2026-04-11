{ inputs, self, ... }: {
        flake.nixosModules.qewa = { pkgs, ... }: {
                users.users.qewa = {
                        isNormalUser = true;
                        description = "Qewa";
                        shell = pkgs.bash;
                        extraGroups = [ "gamemode" "networkmanager" "audio" "wheel" "nixos" ];
                };
                
                home-manager.users.qewa = { pkgs, config, ... }: {
                        imports = [
                                inputs.otter-launcher.homeModules.otter-launcher
                                self.homeModules.base

                                self.homeModules.btop
                                self.homeModules.cava
                                self.homeModules.mango

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
                                        gajim
                                        mumble
                                        labymod-launcher
                                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher
                                        ncdu
                                        brave
                                        wl-clipboard
                                ];

                                file = {
                                        ".config/mango".source = ./mango;
                                        ".init.sh".text = ''
                                                fastfetch
                                                mango > /dev/null 2>&1
                                                exec bash
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
                                                        email = "enthusiast-01bergkessel@icloud.com";
                                                };

                                                safe.directory = "/etc/nixos";
                                                init.defaultBranch = "main";
                                        };
                                };
                        };
                };
        };
}
