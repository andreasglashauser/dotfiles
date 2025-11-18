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
	ln -svf $(DOTFILES_DIR)/llamacpp-bin $(HOME_DIR)/.bashrc.d/llamacpp-bin
	ln -svf $(DOTFILES_DIR)/neovim-bin $(HOME_DIR)/.bashrc.d/neovim-bin
	ln -svf $(DOTFILES_DIR)/tmux-bin $(HOME_DIR)/.bashrc.d/tmux-bin
	mkdir -p $(HOME_DIR)/.local/shims
	ln -sf $(HOME)/repos/tmux/tmux $(HOME)/.local/shims/tmux
	ln -svf $(DOTFILES_DIR)/bun-bin $(HOME_DIR)/.bashrc.d/bun-bin

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

npm:
	@echo "Configuring global npm installs to user-space..."
	npm set prefix $(HOME)/.local

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

llamacpp:
	@echo "Cloning llamacpp..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/ggml-org/llama.cpp.git ~/repos/llama.cpp'
	sh -c 'cd ~/repos/llama.cpp/ && cmake -B build -DGGML_CUDA=ON -DGGML_VULKAN=ON && cmake --build build --config Release'

update-llamacpp:
	@echo "Building llamacpp..."
	sh -c 'cd ~/repos/llama.cpp/ && git pull && cmake -B build && cmake --build build --config Release'


mergiraf:
	@echo "Cloning mergiraf..."
	mkdir -p ~/repos/
	sh -c 'git clone https://codeberg.org/mergiraf/mergiraf.git ~/repos/mergiraf'
	@echo "Building mergiraf, make sure cargo is installed..."
	sh -c 'cd ~/repos/mergiraf && cargo install --path . --root $$HOME/.local'

update-mergiraf:
	@echo "Building and installing mergiraf to $$HOME/.local/..."
	sh -c 'cd ~/repos/mergiraf && cargo install --path . --root $$HOME/.local --force'

typst:
	@echo "Cloning typst..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/typst/typst ~/repos/typst'
	@echo "Building typst, make sure cargo is installed..."
	sh -c 'cd ~/repos/typst && cargo install --path crates/typst-cli --root $$HOME/.local --force'

update-typst:
	@echo "Building typst, make sure cargo is installed..."
	sh -c 'cd ~/repos/typst && cargo install --path crates/typst-cli --root $$HOME/.local --force'

neovim:
	@echo "Cloning neovim..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/neovim/neovim ~/repos/neovim'
	@echo "Building neovim, make sure necessary dev tools are installed (ninja-build, cmake, gcc, make, unzip, gettext, curl)..."
	sh -c 'cd ~/repos/neovim/ && make CMAKE_BUILD_TYPE=Release'

update-neovim:
	@echo "Building and installing neovim to ~/.local/bin..."
	sh -c 'cd ~/repos/neovim/ && git pull && rm -rf build && \
		make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$$HOME/.local" && \
		make install'

tmux:
	@echo "Cloning tmux..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/tmux/tmux ~/repos/tmux'
	@echo "Building tmux, make sure necessary dev tools are installed (autoconf, automake, pkg-config, bison-devel, libevent-devel)..."
	sh -c 'cd ~/repos/tmux/ && sh autogen.sh && ./configure && make'

update-tmux:
	@echo "Building and installing tmux to ~/.local/bin..."
	sh -c 'cd ~/repos/tmux/ && git pull && sh autogen.sh && \
		./configure --prefix=$$HOME/.local && \
		make && make install'

ghostty:
	@echo "Cloning ghostty..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/ghostty-org/ghostty ~/repos/ghostty'
	@echo "Building ghostty, make sure necessary dev tools are installed (gtk4-devel, gtk4-layer-shell-devel, zig, libadwaita-devel, gettext)..."
	sh -c 'cd ~/repos/ghostty/ && zig build -p $$HOME/.local -Doptimize=ReleaseFast'

update-ghostty:
	@echo "Building tmux, make sure necessary dev tools are installed (autoconf, automake, pkg-config)..."
	sh -c 'cd ~/repos/ghostty/ && git pull && zig build -p $$HOME/.local -Doptimize=ReleaseFast'

zig: 
	@echo "Cloning zig..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/ziglang/zig ~/repos/zig'
	@echo "Building zig, make sure necessary dev tools are installed (cmake)..."
	sh -c 'cd ~/repos/zig/ && rm -rf build && mkdir build && cd build && cmake .. && make install'

update-zig:
	@echo "Updating zig..."
	sh -c 'cd ~/repos/zig/ && rm -rf build && git pull && mkdir build && cd build && cmake .. && make install'

bun: 
	@echo "Installing bun..."
	mkdir -p ~/repos/
	sh -c 'git clone https://github.com/oven-sh/bun ~/repos/bun'
	@echo "Buildung bun..."
	npm install -g bun
	sh -c "cd ~/repos/bun/ && bun run build:release"

update-bun:
	@echo "Updating bun..."
	sh -c "cd ~/repos/bun/ && git pull && bun run build:release"

trivy:
	@echo "Cloning trivy..."
	mkdir -p ~/repos/
	if [ ! -d "$$HOME/repos/trivy" ]; then \
		git clone https://github.com/aquasecurity/trivy $$HOME/repos/trivy; \
	fi
	@echo "Building trivy with GOTOOLCHAIN=auto, installing to ~/.local/bin..."
	mkdir -p $$HOME/.local/bin
	sh -c 'cd $$HOME/repos/trivy && GOEXPERIMENT=jsonv2 GOTOOLCHAIN=auto go build -o $$HOME/.local/bin/trivy ./cmd/trivy'

update-trivy:
	@echo "Updating trivy and rebuilding..."
	sh -c 'cd $$HOME/repos/trivy && git pull && GOEXPERIMENT=jsonv2 GOTOOLCHAIN=auto go build -o $$HOME/.local/bin/trivy ./cmd/trivy'
