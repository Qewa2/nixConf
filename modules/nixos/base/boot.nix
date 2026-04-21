{ inputs, ... }: {
        flake.nixosModules.base = { pkgs, config, ... }:
                {
                        imports = [
                                inputs.winit.nixosModules.winit
                        ];

                        environment.systemPackages = [
                                inputs.winit.packages.${pkgs.stdenv.hostPlatform.system}.winit
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
