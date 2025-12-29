{ lib, pkgs, config, ... }:
{
	imports = [
		./qBoot.nix
	];

	options.qConf = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.qConf.enable {
		qConf.qBoot.enable = lib.mkDefault true;
	};
}
