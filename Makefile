DOTFILES_DIR := $(CURDIR)
HOME_DIR := $(HOME)

DOTFILES := Xresources dockerignore editorconfig gitattributes gitconfig gitignore tmux.conf

.PHONY: install clean

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
	ln -svf $(DOTFILES_DIR)/config/nvim $(HOME_DIR)/.config/nvim

	@echo "Creating symlink for SSH configuration..."
	mkdir -p $(HOME_DIR)/.ssh
	ln -svf $(DOTFILES_DIR)/ssh.config $(HOME_DIR)/.ssh/config
	@echo "Done"

clean:
	@echo "Removing symlinks..."
	@for file in $(DOTFILES); do \
		rm -v $(HOME_DIR)/.$$file; \
	done
	rm -v $(HOME_DIR)/.config/nvim
	rm -v $(HOME_DIR)/.ssh/config
