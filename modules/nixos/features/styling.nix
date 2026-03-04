{
        flake.nixosModules.styling = { pkgs, lib, ... }: {
                 stylix = {
                        enable = true;
                        autoEnable = lib.mkDefault true;
                        base16Scheme = lib.mkDefault"${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
                };
        };
}
