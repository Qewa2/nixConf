# nixConf

## How do you use my Config?
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
