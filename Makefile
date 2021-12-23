CONFIG_DIR=~/.config
.PHONY: bootstrap dwm st dwmstat \
		xinit_config sxiv_config rofi_config

bootstrap: dwm dwmstat st xinit_config sxiv_config rofi_config 

dwm:
	@echo "==> Compiling and installing dwm (may be prompted for password)..."
	cd dwm && make clean && make && sudo make install
	@echo "==> Done."

dwmstat:
	@echo "==> Compiling and installing dwmstat..."
	cd dwmstat && make install
	@echo "==> Done."

st:
	@echo "==> Compiling and installing st (may be prompted for password)..."
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

rofi_config: ./config/sxiv/key-handler
	@echo "==> Forcefully hard-linking rofi config..."
	mkdir -p ${CONFIG_DIR}/rofi
	ln -f $^ ${CONFIG_DIR}/rofi
	@echo "==> Done."
