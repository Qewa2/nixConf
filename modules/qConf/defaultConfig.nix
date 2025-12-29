{ lib, pkgs, config, ... }:
{
	imports = [
		./boot.nix
	];

	options.qConf = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.qConf.enable {
		myBoot.enable = lib.mkDefault true;
	};
}
