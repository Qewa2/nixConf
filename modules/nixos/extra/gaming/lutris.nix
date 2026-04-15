{
        flake.nixosModules.lutris = { pkgs, ... }: {
                environment.systemPackages = with pkgs; [
                        steam-run
                        lutris
                        protonup-rs
                        protonplus
                        wine
                        winetricks
                ];
        };
}
