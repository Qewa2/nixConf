# nixConf
## How do you use my Config?
To use my config you can just clone it into your `/etc/nixos`
directory with
```
sudo git clone https://github.com/Qewa2/nixConf.git
```
**However** this does **NOT** activate it 
To use it you should
**1.** add a new host in `flake.nix` and use the modules in the
`modules` in a new configuration file or
**2.** copy your generated `hardware-configuration.nix` file into
`hosts/main/` and edit the `configuration.nix` and `home.nix` files
to your liking

## Activating the config
to activate the Config you just have to run this command:
```
sudo nixos-rebuild switch --flake /etc/nixos/#main
```
or
```
sudo nixo-rebuild switch --flake /etc/nixos/#main --upgrade
```
**Beware** that `/etc/nixos#main` is the `uri` to your flake
e.g. `/etc/nixos/#workstation`

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

## [TODO](./TODO.md)


## Thanks :)
Thanks for checking this config and/or using my config :)
