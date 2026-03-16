{ self, ... }: {
        flake.nixosModules.tails = { pkgs, ... }: {
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
                                        ".config/mango".source = ../qewa/mango;
                                };
                        };

                        programs = {
                                kitty.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                        };
                };
        };
}
