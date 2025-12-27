{ lib, pkgs, config, ... }:
{
	options = {
		myBoot.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.myBoot.enable {
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
					command = lib.mkDefault "${pkgs.tuigreet}/bin/tuigreet --cmd \"hyprland\"";
					user = lib.mkDefault "greeter";
					timeout = lib.mkDefault 10;
				};
			};
		};
	};
}
