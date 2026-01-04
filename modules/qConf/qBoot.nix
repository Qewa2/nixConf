{ lib, pkgs, config, ... }:

let
        bootScript = pkgs.writeShellScript "greetd-boot" ''
                #!/${pkgs.bash}/bin/bash
                ${pkgs.fastfetch}/bin/fastfetch
                ${pkgs.hyprland}/bin/start-hyprland
                exec ${pkgs.bash}/bin/bash
        '';
in
{
	options = {
		qConf.qBoot.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.qConf.qBoot.enable {
		boot.loader.systemd-boot.enable = lib.mkDefault false;
		boot.loader.grub = {
			enable = lib.mkDefault true;
			device = lib.mkDefault "nodev";
			efiSupport = lib.mkDefault true;
			useOSProber = lib.mkDefault true;
		};
		boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

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
}
