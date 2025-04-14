.PHONY: switch update clean check dot nvim emacs scripts

INPUT ?= all

switch:
	sudo nixos-rebuild switch --flake .

update:
ifeq ($(INPUT),all)
	nix flake update
else
	nix flake update $(INPUT)
endif

clean:
	nix-collect-garbage -d
	sudo nix-collect-garbage -d
	rm -f $(HOME)/.config/nvim
	rm -f $(HOME)/.local/scripts
	rm -f $(HOME)/.config/emacs/{init,early-init}.el

check:
	nix flake check

dot: nvim emacs scripts

nvim: target := $(HOME)/.config
nvim:
	mkdir -p $(target)
	ln -sft $(target) $(PWD)/dotfiles/nvim

emacs: target := $(HOME)/.config/emacs
emacs:
	mkdir -p $(target)
	ln -sft $(target) $(PWD)/dotfiles/emacs/early-init.el
	ln -sft $(target) $(PWD)/dotfiles/emacs/init.el

scripts: target := $(HOME)/.local
scripts:
	mkdir -p $(target)
	ln -sft $(target) $(PWD)/dotfiles/scripts
