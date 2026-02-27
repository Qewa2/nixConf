{
        flake.nixosModules.music = { pkgs, ... }: {
                environment.systemPackages = with pkgs; [
                        mpv
                        yt-dlp
                        wiremix
                        self.packages.${pkgs.system}.getMusic
                ];
        };
}
