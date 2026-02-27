{ self, ... }: {
        flake.nixosModules.music = { pkgs, ... }: {
                environment.systemPackages = with pkgs; [
                        mpv
                        wiremix
                        self.packages.${pkgs.system}.getMusic
                ];
        };
}
