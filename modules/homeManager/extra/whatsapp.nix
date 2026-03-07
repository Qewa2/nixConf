{
        flake.hmModules.whatsapp = { pkgs, ... }: {
                home.packages = with pkgs; [
                        whatsapp-electron
                ];
        };
}
