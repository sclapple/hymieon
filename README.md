# My personal dotfiles (hyprland+noctalia) for arch linux based distros (only tested on vanilla arch)

⚠️ **Warning:** This is meant for an Arch minimal install. Do not run this
script (or any script from the internet) unless you know what it does.

## Usage

```bash
git clone https://github.com/sclapple/hymieon
cd hymieon
./Install.sh
```

The install script will install paru, packages, copy configs, and enable services.

## Structure

| Path | Destination |
|------|-------------|
| `home/` | `~/` — user configs (.config, .local, Wallpapers) |
| `etc/` | `/etc/` — system-wide configs |
| `var/` | `/var/` — application data |

## Packages

- **DE:** Hyprland, Noctalia, uwsm
- **Terminal:** Kitty, fish
- **Editor:** Neovim (LazyVim)
- **Media:** MPV (uosc + Anime4K), mpd
- **Gaming:** Steam, Lutris, Wine, MangoHud, GameScope
- **Audio:** PipeWire, WirePlumber

## Notes

- Config files use `__HOME__` placeholders — the install script resolves them at deploy time
- Designed for AMD GPU / Steam ecosystem
