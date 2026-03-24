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
                                        ".config/mango".source = ./mango;
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
