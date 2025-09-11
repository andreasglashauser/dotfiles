This repository contains my personal dotfiles.

To set up these dotfiles on your system, simply clone the repository and run `make` in the repo directory. 
This will automatically create the necessary symlinks:

```
git clone https://github.com/andreasglashauser/dotfiles.git ~/dotfiles
cd ~/dotfiles
make
```

Note that before running the `make` command, it's a good idea to back up any existing dotfiles in case you want to revert later.

Fonts
-----
- `make fonts` installs JetBrains Mono Nerd Font locally and refreshes the font cache.
- Xterm is set to use `JetBrainsMono Nerd Font` via `.Xresources`.
- For other terminals/editors, set the font family to `JetBrainsMono Nerd Font` (or keep your preferred font).
