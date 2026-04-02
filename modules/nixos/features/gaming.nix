{ self, ... }: {
        flake.nixosModules.gaming = { pkgs, ... }: {
                imports = [
                        self.nixosModules.steam
                        self.nixosModules.heroic
                        # self.nixosModules.lutris
                ];

                programs = {
                        gamemode.enable = true;
                        gamescope = {
                                enable = true;
                                capSysNice = true;
                        };
                        steam.gamescopeSession.enable = true;
                };
                
                system.activationScripts.NixOsPermissions = {
                        text = ''
                                gamemoded -t
                        '';
                };
                
                environment.systemPackages = with pkgs; [
                        steam-run
                        (heroic.override {
                                extraPkgs = pkgs': with pkgs'; [
                                        gamescope
                                        gamemode
                                ];
                        })
                ];
        };
}
