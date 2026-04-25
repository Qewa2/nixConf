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
                                        ncdu
                                        brave
                                        wl-clipboard
                                        blender
                                        freecad
                                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.launcher
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.mango
                                ];

                                file = {
                                        ".config/mango/start.sh".source = ./mango/start.sh;
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

                        services = {
                                playerctld.enable = true;
                        };
                };
        };
}
