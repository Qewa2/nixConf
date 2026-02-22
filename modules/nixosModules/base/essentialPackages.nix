{
        flake.nixosModules.base = { pkgs, ... }: {
                environment.systemPackages = with pkgs; [
                        fzf
                        btop
                        fastfetch
                        neofetch
                        ffmpeg
                        sudo
                        lshw
                        unzip
                        bash
                        tree
                        gitFull
                ];
        };
} 
