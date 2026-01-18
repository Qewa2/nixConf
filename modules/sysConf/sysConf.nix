{ lib, config, ... }:
{
	imports = [
		./sysBoot.nix
	];

	options.sysConf = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	config = lib.mkIf config.sysConf.enable {
		sysConf.sysBoot.enable = lib.mkDefault true;
	};
}
