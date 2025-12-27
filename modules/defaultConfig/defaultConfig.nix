{ lib, pkgs, config, ... }:
{
	imports = [
		./boot.nix
	];

	options.defaultConfig = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.defaultConfig.enable {
		myBoot.enable = lib.mkDefault true;
	};
}
