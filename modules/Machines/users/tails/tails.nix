{ inputs, self, ... }: {
        flake.nixosModules.tails = { pkgs, lib, ... }: {
                users.users.tails = {
                        isNormalUser = true;
                        description = "Tails";
                        initialPassword = "";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };

                home-manager.users.tails = {
                        imports = [
                                self.homeModules.base

                                self.homeModules.btop

                                self.homeModules.styling
                        ];

                        home = {
                                username = "tails";
                                homeDirectory = "/home/tails";
                                stateVersion = "25.11";

                                file = {
                                        ".config/mango/config.conf".source = ../qewa/mango/config.conf;
                                        ".config/mango/env.conf".source = ../qewa/mango/env.conf;
                                        ".config/mango/rule.conf".source = ../qewa/mango/rule.conf;
                                        ".config/mango/apperance.conf".source = ../qewa/mango/apperance.conf;
                                        ".config/mango/peripherals".source = ../qewa/mango/peripherals;
                                        ".config/mango/layouts".source = ../qewa/mango/layouts;
                                        ".config/mango/binds".source = ../qewa/mango/binds;
                                        ".config/mango/start.sh".source = ./start.sh;
                                        
                                        "wallpaper.jpg".source = ./kvacm-Cliff.jpg; # https://wallhaven.cc/w/k81776
                                };

                                packages = with pkgs; [
                                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                                ];
                        };

                        programs = {
                                kitty.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                        };
                };
        };
}
