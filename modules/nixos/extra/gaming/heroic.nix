{
        flake.nixosModules.heroic = { pkgs, lib, ... }: {
                environment.systemPackages = with pkgs; [
                        steam-run
                        heroic
                ];
        };
}
