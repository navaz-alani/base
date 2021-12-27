CONFIG_DIR=~/.config
.PHONY: bootstrap dwm st dwmstat \
		theme_setup \
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

# Theme setup

X_ICO_THEME=./config/theme/index.theme
GTK3_SETTINGS=./config/theme/gtk-3.0-settings.ini

theme_setup: ${X_ICO_THEME} ${GTK3_SETTINGS}
	@echo "==> Changing the local system icon theme (may require password)..."
	sudo cp ${X_ICO_THEME} /usr/share/icons/default/index.theme
	@echo "==> Setting configuring GTK3.0 icon theme..."
	mkdir -p ${CONFIG_DIR}/gtk-3.0
	ln -f ${GTK3_SETTINGS} ${CONFIG_DIR}/gtk-3.0/settings.ini


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
	@echo "==> Copying default rofi theme files into place..."
	mkdir -p ${CONFIG_DIR}/rofi
	cp -r ./config/rofi/themes ${CONFIG_DIR}/rofi
	@echo "==> Forcefully hard-linking rofi config..."
	ln -f $< ${CONFIG_DIR}/rofi
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
