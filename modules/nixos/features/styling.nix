{
        flake.nixosModules.styling = { pkgs, lib, config, ... }: {
                stylix = {
                        enable = true;
                        autoEnable = lib.mkDefault true;
                        base16Scheme = lib.mkDefault"${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
                        fonts = {
                                monospace = lib.mkDefault {
                                        package = pkgs.nerd-fonts.fira-code;
                                        name = "FiraCode Nerd Font Mono";
                                };

                                serif = lib.mkDefault config.stylix.fonts.monospace;
                                sansSerif = lib.mkDefault config.stylix.fonts.monospace;
                                emoji = lib.mkDefault config.stylix.fonts.monospace;
                        };
                };
                boot.plymouth.enable = true;
        };
}
