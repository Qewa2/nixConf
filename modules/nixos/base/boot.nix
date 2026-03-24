{ inputs, ... }: {
        flake.nixosModules.base = { pkgs, config, ... }:
                let
                        bootScript = pkgs.writeShellScript "greetd-boot" ''
                                #!/${pkgs.bash}/bin/bash
                                ${pkgs.fastfetch}/bin/fastfetch
                                ${config.programs.mango.package}/bin/mango > /dev/null 2>&1
                                exec ${pkgs.bash}/bin/bash
                        '';
                in
                {
                        imports = [
                                inputs.winit.nixosModules.winit
                        ];

                        environment.systemPackages = [
                                inputs.winit.packages.${pkgs.stdenv.hostPlatform}.winit
                        ];

                        programs.winit.enable = true;

                        boot = {
                                loader = {
                                        systemd-boot.enable = false;
                                        grub = {
                                                enable = true;
                                                device = "nodev";
                                                efiSupport = true;
                                                useOSProber = true;
                                        };
                                        efi.canTouchEfiVariables = true;
                                };
                        };

                        services.greetd = {
                                enable = true;
                                settings = {
                                        default_session = {
                                                command = "${pkgs.tuigreet}/bin/tuigreet \\
                                                --cmd \"winit\"";
                                                user = "greeter";
                                                timeout = 10;
                                        };
                                };
                        };
                };
}
