{ ... }: {
        flake.nixosModules.base.boot = { lib, pkgs, config, ... }:
                let
                        cfg = config.base.boot;
                        bootScript = pkgs.writeShellScript "greetd-boot" ''
                                ${config.sysConf.sysBoot.onBoot}
                        '';
                in
                {
                        options.base.boot = {
                                enable = lib.mkOption {
                                        type = lib.types.bool;
                                        default = false;
                                };

                                onBoot = lib.mkOption {
                                        type = lib.types.str;
                                        default = ''
                                                #!/${pkgs.bash}/bin/bash
                                                ${pkgs.fastfetch}/bin/fastfetch
                                                ${config.programs.mango.package}/bin/mango > /dev/null 2>&1
                                                exec ${pkgs.bash}/bin/bash
                                        '';
                                };

                        };

                        config = lib.mkIf cfg.enable {
                                boot = {
                                        loader = {
                                                systemd-boot.enable = lib.mkDefault false;
                                                grub = {
                                                        enable = lib.mkDefault true;
                                                        device = "nodev";
                                                        efiSupport = lib.mkDefault true;
                                                        useOSProber = lib.mkDefault true;
                                                };
                                                efi.canTouchEfiVariables = lib.mkDefault true;
                                        };
                                };

                                services.greetd = {
                                        enable = lib.mkDefault true;
                                        settings = {
                                                default_session = {
                                                        command = lib.mkDefault "${pkgs.tuigreet}/bin/tuigreet \\
                                                        --cmd \"${bootScript}\"";
                                                        user = lib.mkDefault "greeter";
                                                        timeout = lib.mkDefault 10;
                                                };
                                        };
                                };
                        };
                };
}
