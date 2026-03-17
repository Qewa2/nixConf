{ inputs, self, ... }: {
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
                                        ".config/mango/config.conf".source = ../qewa/mango/config.conf;
                                        ".config/mango/bind.conf".source = ../qewa/mango/bind.conf;
                                        ".config/mango/binds.md".source = ../qewa/mango/binds.md;
                                        ".config/mango/env.conf".source = ../qewa/mango/env.conf;
                                        ".config/mango/monitors.conf".source = ../qewa/mango/monitors.conf;
                                        ".config/mango/rule.conf".source = ../qewa/mango/rule.conf;
                                        ".config/mango/start.sh".source = ./start.sh;
                                        "wallpaper.jpg".source = ./Gradient.jpg; # https://wallhaven.cc/w/70p7p0
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
