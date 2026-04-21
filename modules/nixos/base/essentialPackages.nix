{ self, ... }: {
        flake.nixosModules.base = { pkgs, ... }: {
                environment.systemPackages = with pkgs; [
                        fzf
                        btop
                        fastfetch
                        ffmpeg
                        sudo
                        lshw
                        unzip
                        bash
                        tree
                        gitFull
                        coreutils-full
                        self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
                ];

                programs = {
                        yazi.enable = true;
                        lazygit.enable = true;
                };
        };
} 
