{
        flake.homeModules.styling = { lib, ... }: {
                stylix = {
                        enable = true;
                        autoEnable = true;
                        polarity = lib.mkDefault "either";
                };
        };
}
