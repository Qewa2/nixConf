{
        flake.nixosModules.styling = { pkgs, ... }: {
                 stylix = {
                        enable = true;
                        autoEnable = true;
                        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
                };
        };
}
