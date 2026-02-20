{
        flake.nixosModules.base = { lib, pkgs, ... }: {
                nix.settings.experimental-features = [ "nix-command" "flakes" ];
                nixpkgs.config = {
                        allowUnfree = true;
                        allowUnfreePredicate = _: true;
                };

                programs.nh = {
                        enable = true;
                        flake = lib.mkDefault "/etc/nixos";
                };

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
