CONFIG_DIR=~/.config
.PHONY: bootstrap dwm dwmstat \
		xinit_config kitty_config sxiv_config rofi_config

bootstrap: dwm dwmstat xinit_config kitty_config sxiv_config rofi_config 

dwm:
	@echo "==> Compiling and installing dwm (may be prompted for password)..."
	cd dwm && make clean && make && sudo make install
	@echo "==> Done."

dwmstat:
	@echo "==> Compiling and installing dwmstat..."
	cd dwmstat && make install
	@echo "==> Done."

# Application configs

xinit_config: ./config/.xinitrc
	@echo "==> Forcefully hard-linking xinit config..."
	ln -f $^ ~
	@echo "==> Done."

kitty_config: ./config/kitty/kitty.conf
	@echo "==> Forcefully hard-linking kitty config..."
	mkdir -p ${CONFIG_DIR}/kitty
	ln -f $^ ${CONFIG_DIR}/kitty
	@echo "==> Done."

sxiv_config: ./config/sxiv/key-handler
	@echo "==> Forcefully hard-linking sxiv config..."
	mkdir -p ${CONFIG_DIR}/sxiv/exec
	ln -f $^ ${CONFIG_DIR}/sxiv/exec
	@echo "==> Done."

rofi_config: ./config/sxiv/key-handler
	@echo "==> Forcefully hard-linking rofi config..."
	mkdir -p ${CONFIG_DIR}/rofi
	ln -f $^ ${CONFIG_DIR}/rofi
	@echo "==> Done."
