{ lib, pkgs, config, ... }:

let
        bootScript = pkgs.writeShellScript "greetd-boot" ''
                ${config.sysConf.sysBoot.onBoot}
        '';
in
{
	options = {
		sysConf.sysBoot.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};

                sysConf.sysBoot.onBoot = lib.mkOption {
                        type = lib.types.str;
                        default = ''
                                #!/${pkgs.bash}/bin/bash
                                ${pkgs.fastfetch}/bin/fastfetch
                                ${config.programs.mango.package}/bin/mango > /dev/null 2>&1
                                exec ${pkgs.bash}/bin/bash
                        '';
                };
	};

	config = lib.mkIf config.sysConf.sysBoot.enable {
	        boot = {
                        loader = {
                                systemd-boot.enable = lib.mkDefault false;
		                grub = {
			                enable = lib.mkDefault true;
			                device = lib.mkDefault "nodev";
			                efiSupport = lib.mkDefault true;
			                useOSProber = lib.mkDefault true;
                                };
		                efi.canTouchEfiVariables = lib.mkDefault true;
                        };
                };

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
