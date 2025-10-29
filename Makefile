DOTFILES_DIR := $(CURDIR)
HOME_DIR := $(HOME)

DOTFILES := Xresources gitconfig tmux.conf gitignore

install:
	@echo "Creating symlinks for dotfiles..."
	@for file in $(DOTFILES); do \
		echo "Creating link: $(HOME_DIR)/.$$file -> $(DOTFILES_DIR)/$$file"; \
		ln -svf $(DOTFILES_DIR)/$$file $(HOME_DIR)/.$$file; \
	done


	@echo "Creating symlinks for bashrc..."
	mkdir -p $(HOME_DIR)/.bashrc.d
	ln -svf $(DOTFILES_DIR)/aliases $(HOME_DIR)/.bashrc.d/aliases
	ln -svf $(DOTFILES_DIR)/tmux-autostart.sh $(HOME_DIR)/.bashrc.d/tmux-autostart.sh
	ln -svf $(DOTFILES_DIR)/killport $(HOME_DIR)/.bashrc.d/killport
	ln -svf $(DOTFILES_DIR)/mason-bin $(HOME_DIR)/.bashrc.d/mason-bin

	@echo "Creating symlink for Neovim configuration..."
	mkdir -p $(HOME_DIR)/.config
	rm -f $(HOME_DIR)/.config/nvim
	ln -sv $(DOTFILES_DIR)/config/nvim $(HOME_DIR)/.config/nvim

	@echo "Creating symlink for ssh configuration..."
	mkdir -p $(HOME_DIR)/.ssh
	rm -f $(HOME_DIR)/.ssh/ssh_config
	ln -sv $(DOTFILES_DIR)/ssh_config $(HOME_DIR)/.ssh/config

	@echo "Done"

clean:
	@echo "Removing symlinks..."
	@for file in $(DOTFILES); do \
		rm -v $(HOME_DIR)/.$$file; \
	done
	rm -v $(HOME_DIR)/.config/nvim
	rm -v $(HOME_DIR)/.ssh/config

csp:
	@echo "Creating directories for git projects for work at CSP..."
	mkdir -p $(HOME_DIR)/repos/csp
	ln -svf $(DOTFILES_DIR)/gitconfig-csp $(HOME_DIR)/repos/csp/.gitconfig; \

vimplug:
	@echo "Installing vim-plug..."
	sh -c 'curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

FONT_NAME := JetBrainsMono
FONT_ZIP  := $(FONT_NAME).zip
FONT_URL  := https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$(FONT_ZIP)
FONT_DIR  := $(HOME)/.local/share/fonts
TMP_DIR   := $(HOME)/.cache/dotfiles-fonts

fonts:
	@set -e; \
	echo ">> Installing $(FONT_NAME) Nerd Font (user scope)"; \
	command -v curl >/dev/null 2>&1 || { echo "curl not found"; exit 1; }; \
	command -v unzip >/dev/null 2>&1 || { echo "unzip not found"; exit 1; }; \
	mkdir -p "$(TMP_DIR)" "$(FONT_DIR)"; \
	echo ">> Downloading $(FONT_URL)"; \
	curl -fsSL "$(FONT_URL)" -o "$(TMP_DIR)/$(FONT_ZIP)"; \
	echo ">> Unzipping to $(FONT_DIR)"; \
	unzip -oq "$(TMP_DIR)/$(FONT_ZIP)" -d "$(FONT_DIR)"; \
	echo ">> Refreshing font cache"; \
	fc-cache -fv >/dev/null; \
	echo ">> Done. Set your terminal font to a *Nerd Font* variant of $(FONT_NAME)."
