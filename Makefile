DOTFILES_DIR := $(CURDIR)
HOME_DIR := $(HOME)

DOTFILES := Xresources gitconfig tmux.conf gitignore

.PHONY: install clean fonts

install:
	@echo "Creating symlinks for dotfiles..."
	@for file in $(DOTFILES); do \
		echo "Creating link: $(HOME_DIR)/.$$file -> $(DOTFILES_DIR)/$$file"; \
		ln -svf $(DOTFILES_DIR)/$$file $(HOME_DIR)/.$$file; \
	done

	@echo "Creating symlink aliases..."
	mkdir -p $(HOME_DIR)/.bashrc.d
	ln -svf $(DOTFILES_DIR)/aliases $(HOME_DIR)/.bashrc.d/aliases

	@echo "Creating symlink for Neovim configuration..."
	mkdir -p $(HOME_DIR)/.config
	rm -f $(HOME_DIR)/.config/nvim
	ln -sv $(DOTFILES_DIR)/config/nvim $(HOME_DIR)/.config/nvim

	@echo "Installing fonts..."
	$(MAKE) fonts

	@echo "Done"

clean:
	@echo "Removing symlinks..."
	@for file in $(DOTFILES); do \
		rm -v $(HOME_DIR)/.$$file; \
	done
	rm -v $(HOME_DIR)/.config/nvim
	rm -v $(HOME_DIR)/.ssh/config

fonts:
	@echo "Installing JetBrains Mono Nerd Font..."
	@mkdir -p $(HOME_DIR)/.local/share/fonts
	@curl -L -o $(HOME_DIR)/.local/share/fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
	@cd $(HOME_DIR)/.local/share/fonts && unzip -o JetBrainsMono.zip
	@rm -f $(HOME_DIR)/.local/share/fonts/JetBrainsMono.zip
	@fc-cache -fv
	@echo "Font installation complete"
