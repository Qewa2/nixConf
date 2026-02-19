{ inputs, self, ... }: {
        flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
                modules = [
                        self.nixosModules.mainModule
                        self.home-manager.nixosModules.default
                        self.stylix.nixosModules.stylix
                        self.mango.nixosModules.mango
                        ./hardware
                ];
        };

        flake.nixosModules.mainModule = { inputs, pkgs, config, ... }: {
                imports = [
                        inputs.home-manager.nixosModules.default
                ];
                
                sysConf = {
                        enable = true;
                        sysBoot.enable = true;
                        sysSound.enable = true;
                };

                dotfiles.enableAll = true;

                myConfigs.enableAll = true;

                hardware.bluetooth = {
                        enable = true;
                        powerOnBoot = true;
                        settings = {
                                General = {
                                        Experimental = true;
                                        FastConnectable = true;
                                };

                                Policy = {
                                        AutoEnable = false;
                                };
                        };
                };

                networking = {
                        hostName = "nixos";
                        networkmanager = {
                                enable = true;
                                wifi.backend = "iwd";
                        };
                        wireless.iwd.enable = true;
                };

                systemd.services.iwd.wantedBy = [ "multi-user.target" ];

                system.activationScripts.NixOsPermissions = {
                        text = ''
                                chown root:nixos /etc/nixos
                                find /etc/nixos -exec chown root:nixos {} +
                                find /etc/nixos -type d -exec chmod -R 774 {} +
                                find /etc/nixos -type f -exec chmod -R 664 {} +
                        '';
                };

                systemd.tmpfiles.rules = [
                        "d /etc/nixos 0775 root nixos -"
                ];

                nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

                users.groups.nixos.gid = 991;

                users.users.qewa = {
                        isNormalUser = true;
                        description = "Qewa";
                        shell = pkgs.bash;
                        extraGroups = [ "networkmanager" "audio" "wheel" "nixos" ];
                };

                home-manager = {
                        extraSpecialArgs = { inherit inputs; };
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users = {
                                qewa = ./home.nix;
                        };
                };

                nixpkgs.config = {
                        allowUnfree = true;
                        allowUnfreePredicate = (_: true);
                };

                environment.systemPackages = with pkgs; [
                        btop
                        neofetch
                        fastfetch
                        gitFull
                        lazygit
                        yazi
                        ncdu
                        brave
                        ffmpeg
                        wl-clipboard
                        rofi
                        pavucontrol
                        tree
                        bash
                        sudo
                        hyprcursor
                        bibata-cursors
                        lshw
                        fzf
                        unzip
                        bluetui
                        impala
                        inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
                ];

                services.pairdrop = {
                        enable = true;
                        port = 3000;
                };

                programs.nh.enable = true;

                programs.steam = {
                        enable = true;
                        remotePlay.openFirewall = true;
                        dedicatedServer.openFirewall = true;
                        localNetworkGameTransfers.openFirewall = true;
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
                programs.gnupg.agent = {
                        enable = true;
                        enableSSHSupport = true;
                };

                services.openssh.enable = true;

                networking.firewall.allowedTCPPorts = [ 22 3000 ];
                system.stateVersion = "25.11";
        };
}
