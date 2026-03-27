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
                                stateVersion = "26.05";

                                file = {
                                        ".config/mango".source = ./mango;
                                        "wallpaper.jpg".source = ./kvacm-Cliff.jpg; # https://wallhaven.cc/w/k81776
                                        ".init.sh".text = ''
                                                #!${pkgs.lib.getExe pkgs.bash}
                                                ${pkgs.lib.getExe pkgs.fastfetch}
                                                mango > /dev/null 2>&1
                                                exec ${pkgs.lib.getExe pkgs.bash}
                                        '';
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
