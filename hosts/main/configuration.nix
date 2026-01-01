# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
        imports =
        [ # Include the results of the hardware scan.
                ./hardware-configuration.nix
                inputs.home-manager.nixosModules.default
                ../../modules/qConf/qConf.nix
        ];
  
        qConf.enable = true;
        networking.hostName = "nixos"; # Define your hostname.
        # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
        # Configure network proxy if necessary
        # networking.proxy.default = "http://user:password@proxy:port/";
        # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

        # Enable networking
        networking.networkmanager.enable = true;
  
        system.activationScripts.NixOsPermissions = {
                text = ''
                        chown root:nixos /etc/nixos
                        find /etc/nixos -exec chown root:nixos {} +
                        find /etc/nixos -type d -exec chmod -R 774 {} +
                        find /etc/nixos -type f -exec chmod -R 664 {} +
                        chmod -R 774 /etc/nixos/modules/qConf/boot.sh
                '';
        };

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Set your time zone.
        time.timeZone = "Europe/Berlin";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_US.UTF-8";

        i18n.extraLocaleSettings = {
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

        # Configure keymap in X11
        services.xserver.xkb = {
                layout = "de";
                variant = "";
        };

        # Configure console keymap
        console.keyMap = "de";

        # Create the nixos group
        users.groups.nixos = {
                gid = 991;
        };

        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.qewa = {
                isNormalUser = true;
                description = "Qewa";
                shell = pkgs.bash;
                extraGroups = [ "networkmanager" "wheel" "nixos" ];
                packages = with pkgs; [];
        };

        home-manager = {
                extraSpecialArgs = { inherit inputs; };
                useGlobalPkgs = true;
                useUserPackages = true;
                users = {
                        qewa = ./home.nix;
                };
        };

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowUnfreePredicate = (_: true);

        # Change ownership of /etc/nixos to the nixos group
        systemd.tmpfiles.rules = [
                "d /etc/nixos 0775 root nixos -"
        ];

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
                btop
                neofetch
                fastfetch
                gitFull
                kitty
                brave
                ffmpeg
                wl-clipboard
                wofi
                pulseaudio
                pavucontrol
                tree
                bash
                sudo
                hyprcursor
                bibata-cursors
                lshw
                fzf
                inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
        ];

        programs.nvf = {
                enable = true;
                settings.vim = {
                        theme = {
                                enable = true;
                                name = "gruvbox";
                                style = "dark";
                        };
      
                        statusline.lualine.enable = true;
                        telescope.enable = true;
                        autocomplete.nvim-cmp.enable = true;
                        
                        lsp.enable = true;
                        languages = {
                                enableTreesitter = true;
                                nix.enable = true;
                                clang.enable = true;
                                python.enable = true;
                        };
                };
        };

        programs.steam = {
                enable = true;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
                localNetworkGameTransfers.openFirewall = true;
        };

        programs.hyprland = {
                enable = true;
                package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };

        services.pipewire.enable = false;
        services.pulseaudio.enable = true;
        services.pulseaudio.support32Bit = true;
  
        # Nvidia
        hardware.graphics.enable = true;
        services.xserver.videoDrivers = ["nvidia"];
        hardware.nvidia = {
                modesetting.enable = true;
                powerManagement.enable = false;
                powerManagement.finegrained = false;
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

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        programs.mtr.enable = true;
        programs.gnupg.agent = {
                enable = true;
                enableSSHSupport = true;
        };

        # List services that you want to enable:

        # Enable the OpenSSH daemon.
        services.openssh.enable = true;

        # Open ports in the firewall.
        networking.firewall.allowedTCPPorts = [ 22 ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # networking.firewall.enable = false;

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "25.11"; # Did you read the comment?
}
