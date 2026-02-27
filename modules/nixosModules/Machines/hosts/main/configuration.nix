{ inputs, self, ... }: {
        flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
                modules = [
                        self.nixosModules.main
                        self.nixosModules.main-hardware
                        inputs.home-manager.nixosModules.default
                        inputs.stylix.nixosModules.stylix
                        inputs.mango.nixosModules.mango
                ];
        };

        flake.nixosModules.main = { pkgs, ... }: {
                imports = [
                        self.nixosModules.base
                        self.nixosModules.bluetooth
                        self.nixosModules.wifi
                        self.nixosModules.ssh
                        self.nixosModules.gaming
                        self.nixosModules.music
                        self.nixosModules.qewa
                ];

                networking.hostName = "nixos";

                stylix = {
                        enable = true;
                        autoEnable = true;
                        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
                };

                time.timeZone = "Europe/Berlin";

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

                console.keyMap = "de";

                environment.systemPackages = with pkgs; [
                        lazygit
                        yazi
                        ncdu
                        brave
                        wl-clipboard
                        rofi
                        pavucontrol
                        hyprcursor
                        bibata-cursors
                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                ];

                services.pairdrop = {
                        enable = true;
                        port = 3000;
                };

                boot.plymouth.enable = true;

                hardware.graphics.enable = true;
                services.xserver.videoDrivers = [ "nvidia" ];
                hardware.nvidia = {
                        modesetting.enable = true;
                        powerManagement = {
                                enable = false;
                                finegrained = false;
                        };
                        open = false;
                        nvidiaSettings = true;
                        prime = {
                                sync.enable = true;
                                intelBusId = "PCI:0:2:0";
                                nvidiaBusId = "PCI:1:0:0";
                        };
                };

                environment.variables = {
                        EDITOR = "nvim";
                        HYPRCURSOR_THEME = "Bibata-Modern-Classic";
                        HYPRCURSOR_SIZE = 24;
                        XCURSOR_THEME = "Bibata-Modern-Classic";
                        XCURSOR_SIZE = 24;
                };

                programs.mtr.enable = true;
                networking.firewall.allowedTCPPorts = [ 3000 ];
                system.stateVersion = "25.11";
        };
}
