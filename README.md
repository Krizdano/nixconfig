# NixOS

my personal `NixOS` configuration

This is a collection of my personal configuration files for the `NixOS` operating system. This repo contains configurations for a custom `NixOS` iso, a virtual machine and my laptop 


This is not intended to be used by others, but rather to serve as a reference or inspiration for creating your own `NixOS` configuration. It contains some files that are encrypted with [git crypt](https://github.com/AGWA/git-crypt). It also uses the [impermanence module](https://github.com/nix-community/impermanence) to create an opt-in State for my root and home ( which is created using the help of this [guide]( https://gist.github.com/hadilq/a491ca53076f38201a8aa48a0c6afef5) ) so that only specified files and folders persist between reboots.

If you want to learn from my `NixOS` configuration, you can clone this repository to your local machine and explore the files. However, you will not be able to run or deploy it without modifying it to suit your own needs and preferences.





