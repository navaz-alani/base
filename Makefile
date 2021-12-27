CONFIG_DIR=~/.config
.PHONY: bootstrap dwm st dwmstat \
		xinit_config sxiv_config rofi_config zsh_config dunst_config

bootstrap:
	@echo "==> Bootstrapping the system"
	@echo "==> Installing dependencies..."
	./setup/install-deps
	@make dwm dwmstat st
	@make zsh_config xinit_config sxiv_config rofi_config
	@echo "==> Setting up zsh"
	./setup/zsh-setup

dwm:
	@echo "==> Compiling and installing dwm (may require password)..."
	cd dwm && make clean && make && sudo make install
	@echo "==> Done."

dwmstat:
	@echo "==> Compiling and installing dwmstat (may require password)..."
	cd dwmstat && make && sudo make install
	@echo "==> Done."

st:
	@echo "==> Compiling and installing st (may require password)..."
	cd st && make clean && make && sudo make install
	@echo "==> Done."

# Application configs

xinit_config: ./config/.xinitrc
	@echo "==> Forcefully hard-linking xinit config..."
	ln -f $^ ~
	@echo "==> Done."

sxiv_config: ./config/sxiv/key-handler
	@echo "==> Forcefully hard-linking sxiv config..."
	mkdir -p ${CONFIG_DIR}/sxiv/exec
	ln -f $^ ${CONFIG_DIR}/sxiv/exec
	@echo "==> Done."

rofi_config: ./config/rofi/config.rasi
	@echo "==> Forcefully hard-linking rofi config..."
	mkdir -p ${CONFIG_DIR}/rofi
	ln -f $^ ${CONFIG_DIR}/rofi
	@echo "==> Done."

zsh_config: ./config/zsh/.zshrc
	@echo "==> Setting ZDOTDIR to ~/.config/zsh (may require password)..."
	sudo sed -i 's/ZDOTDIR=.*/ZDOTDIR=$${HOME}\/.config\/zsh/' /etc/zsh/zshenv
	@echo "==> Forcefully hard-linking zsh config..."
	mkdir -p ${CONFIG_DIR}/zsh
	ln -f $^ ${CONFIG_DIR}/zsh
	@echo "==> Done (if you haven't, run zsh_setup)."

dunst_config: ./config/dunst/dunstrc
	@echo "==> Forcefully hard-linking dunst config..."
	mkdir -p ${CONFIG_DIR}/dunst
	ln -f $^ ${CONFIG_DIR}/dunst
	@echo "==> Done."

%: %.def
	@echo "==> Using default config $^"
	cp $^ $@
