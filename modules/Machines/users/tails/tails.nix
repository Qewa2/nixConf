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
                                        ".config/mango".source = ../qewa/mango;
                                        "wallpaper.jpg".source = ./Gradient.jpg; # https://wallhaven.cc/w/70p7p0
                                };

                                packages = with pkgs; [
                                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                                ];
                        };


                        systemd.user.services.set-wallpaper = {
                                Unit.Description = "Set wallpaper for awww";
                                Service = {
                                        Type = "oneshot";
                                        ExecStart = "${pkgs.lib.getExe inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww} img /home/tails/wallpaper.jpg";
                                };
                                Install.WantedBy = [ "graphical-session.target" ];
                        };

                        programs = {
                                kitty.enable = true;
                                rofi.enable = true;
                                yazi.enable = true;
                        };
                };
        };
}
