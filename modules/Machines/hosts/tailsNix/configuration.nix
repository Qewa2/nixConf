{ inputs, self, ... }: {
        flake.nixosConfigurations.tailsNix = inputs.nixpkgs.lib.nixosSystem {
                modules = [
                        inputs.home-manager.nixosModules.default
                        inputs.stylix.nixosModules.stylix
                        inputs.mangowm.nixosModules.mango

                        self.nixosModules.tailsNix
                ];
        };

        flake.nixosModules.tailsNix = { pkgs, lib, modulesPath, ... }: {
                imports = [
                        "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

                        self.nixosModules.base

                        self.nixosModules.wifi
                        self.nixosModules.bluetooth

                        self.nixosModules.styling

                        self.nixosModules.tails
                ];

                nixpkgs.hostPlatform = "x86_64-linux";

                networking.hostName = "tailsNix";

                time.timeZone = "Europe/Berlin";

                users.users = {
                        nixos = {
                                hashedPassword = "!";
                                hashedPasswordFile = lib.mkForce null;

                                initialHashedPassword = lib.mkForce null;
                                initialPassword = lib.mkForce null;
                                password = lib.mkForce null;

                                extraGroups = [];
                        };

                        root = {
                                hashedPassword = "!";
                                hashedPasswordFile = lib.mkForce null;

                                initialHashedPassword = lib.mkForce null;
                                initialPassword = lib.mkForce null;
                                password = lib.mkForce null;
                        };
                };

                i18n = {
                        defaultLocale = "en_US.UTF-8";

                        extraLocaleSettings = {
                                LC_ADDRESS = "de_DE.UTF-8";
                                LC_IDENTIFICATION = "de_DE.UTF-8";
                                LC_MEASUREMENT = "de_DE.UTF-8";
                                LC_MONETARY = "de_DE.UTF-8";
                                LC_NAME = "de_DE.UTF-8";
                                LC_NUMERIC = "de_DE.UTF-8";
                                LC_PAPER = "de_DE.UTF-8";
                                LC_TELEPHONE = "de_DE.UTF-8";
                                LC_TIME = "de_DE.UTF-8";
                        };
                };

                services.xserver.xkb = {
                        layout = "de";
                        variant = "";
                };

                environment = {
                        systemPackages = with pkgs; [
                                tor-browser
                                brave
                        ];

                        variables = {
                                EDITOR = "nvim";
                        };
                };

                services.tor = {
                        enable = true;
                        client.enable = true;
                        relay.enable = false;
                        openFirewall = false;
                        enableGeoIP = false;
                        torsocks.enable = true;
                };

                programs.mango.enable = true;
        };
}
