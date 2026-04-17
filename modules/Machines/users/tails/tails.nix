{ inputs, self, ... }: {
        flake.nixosModules.tails = { pkgs, ... }: {
                users.users.tails = {
                        isNormalUser = true;
                        description = "Tails";
                        initialPassword = "";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };

                home-manager.users.tails = { pkgs, config, ... }: {
                        imports = [
                                self.homeModules.base

                                self.homeModules.btop

                                self.homeModules.styling
                                self.homeModules.development
                        ];

                        home = {
                                username = "tails";
                                homeDirectory = "/home/tails";
                                stateVersion = "26.05";

                                file = {
                                        ".config/mango/start.sh".source = ./mango/start.sh;
                                        "wallpaper.jpg".source = ./kvacm-Cliff.jpg; # https://wallhaven.cc/w/k81776
                                        ".init.sh".text = ''
                                                fastfetch
                                                mango > /dev/null 2>&1
                                                exec bash
                                        '';
                                };

                                packages = with pkgs; [
                                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

                                        self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.launcher
                                        self.packages.${pkgs.stdenv.hostPlatform.system}.mango

                                        wl-clipboard
                                ];
                        };

                        programs = {
                                kitty.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                        };

                        services = {
                                playerctld.enable = true;
                        };
                };
        };
}
