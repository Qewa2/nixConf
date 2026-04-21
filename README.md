# nixConf

## How do you use my Config?
### Add your own Confgi
To use my config you can just clone it with
```
git clone https://github.com/Qewa2/nixConf.git
```
**However** this does **NOT** activate it 
To use it you should
**1.** add a new host as a module like with my `main` host and create new module
for your host and your preferences and user just like with `qewa`

**2.** Create a module for yor hardware configuration.
I usually name mine with `hostname` + `'-hardware'`

### Use my packages
you can also use it by including this flake like this
```
{
        inputs = {
                qconf = {
                        url = "github:Qewa2/nixConf";
                        inputs.nixpkgs.follows = "nixpkgs";
                        # if you want other inputs to follow your update cycle add them like this here
                        # However my update cycle is pretty regular so you might not even need nixpkgs
                };
        };
}
```

then you can use my packages and my wrappers by adding them to your system packages ot your user packages
```
# system wide
environment.systemPackage = [
        inputs.qconf.packages.${pkgs.stdenv.hostPlatform.system}.mango # Example you can use whatever you find
];

# home home manager
home.packages = [
        inputs.qconf.packages.${pkgs.stdenv.hostPlatform.system}.mango
]
```

### Use my modules
just include my modules to your configuration
the are always named like this:
nixos:
```
inputs.qconf.nixosModules.base # Example you can use others as well
```
home manager:
```
inputs.qconf.homeModules.base
```


## Activating the config
to activate the Config you just have to run this command:
```
sudo nixos-rebuild switch --flake <flake path>#<config name>
```
in my case it would be:
```
sudo nixos-rebuild switch --flake ~/git/nixConf#main
```

## Home-manager
Homa-manager is installed as a nixos-module witch makes it a Part
of the nixos configuration.
This means you don't have to run 
```
home-manager switch
```
or 
```
nix run home-manager switch
```
when changing you home config.
It should be done automacally when you rebuild your system with
```
sudo nixos-rebuild switch --flake <flake uri>
```

## **Updating and rebuilding**
My config installs nh the nix helper.
So you can just rebuild with
```
nh os switch <config-path> -H <config name>
```
Example:
```
nh os switch /etc/nixos -H main
```

i set the default flake path of nh to `/etc/nixos` so if you have your
config there you can just run
```
nh os switch -H <config name>
```
or you can set the nh flake path to something else in your configuration
and you can still run this command


## [TODO](./TODO.md)


## Thanks :)
Thanks for checking this config and/or using my config :)
