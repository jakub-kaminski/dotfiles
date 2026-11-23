# Display Color Settings Specification

> For AI agents and humans configuring Jakub's display environment.

## Quick Start

```bash
bash apply.sh          # apply all settings
bash apply.sh --check  # dry run
```

## Confirmed-Good Settings (Feb 2026)

These values produce the exact visual appearance Jakub uses daily.
Tested on: Ubuntu 24.10, NVIDIA GTX 1070, 4K 27" monitor via DisplayPort.
Matches: Dell laptop, Ubuntu 22.04, NVIDIA Quadro P3200, 4K 27" via HDMI.

### Display Gamma Ramp

| Parameter | Value | Purpose |
|-----------|-------|---------|
| Color temperature | **3900K** | Warm amber cast (reduces eye strain) |
| Red gamma | **1.0** | Standard — no correction |
| Green gamma | **1.2** | Darken green midtones (warmer) |
| Blue gamma | **1.4** | Darken blue midtones (warmer) |
| Brightness | **1.0** | Full brightness — no dimming |

Applied via `set_gamma_ramp.py` which writes directly to the X11 gamma LUT.
This replaces both `redshift` and `xrandr --gamma` — neither can correctly
combine per-channel temperature scaling + gamma + full brightness.

### Why Not Redshift or xrandr?

- `redshift -O 3900` forces brightness to 0.85 (can't override)
- `xrandr --gamma 1.0:1.2:1.4` can't add temperature scaling
- `xrandr --brightness` overwrites the entire gamma ramp
- `redshift -O 3900 -g 1.0:1.2:1.4` combines them but still dims to 0.85
- **Solution**: Write the gamma LUT directly via Xrandr C API (set_gamma_ramp.py)

### DPI & Resolution

| Setting | Value |
|---------|-------|
| Resolution | 3840x2160 (4K) @ 60Hz |
| DPI | 220 (via `xrandr --dpi 220` and `Xft.dpi: 220`) |
| Cursor size | 64px |
| Cursor theme | DMZ-White |

### NVIDIA GPU Settings

| Setting | Value | Meaning |
|---------|-------|---------|
| ColorSpace | 0 | RGB |
| ColorRange | 0 | Full (0-255, not limited 16-235) |
| CurrentDithering | 1 | Temporal dithering ON |
| ICC profile | None | No display ICC profile active |

**Do not** install ICC profiles or change ColorRange to limited without asking.

## 16-Color ANSI Palette (from ~/.Xresources)

| Index | Name | Hex |
|-------|------|-----|
| 0 | Black | `#1b1918` |
| 1 | Red | `#f22c40` |
| 2 | Green | `#5ab738` |
| 3 | Yellow | `#d5911a` |
| 4 | Blue | `#407ee7` |
| 5 | Magenta | `#6666ea` |
| 6 | Cyan | `#00ad9c` |
| 7 | White | `#a8a19f` |
| 8 | Bright Black | `#766e6b` |
| 9 | Bright Red | `#f22c40` |
| 10 | Bright Green | `#5ab738` |
| 11 | Bright Yellow | `#d5911a` |
| 12 | Bright Blue | `#407ee7` |
| 13 | Bright Magenta | `#6666ea` |
| 14 | Bright Cyan | `#00ad9c` |
| 15 | Bright White | `#f1efee` |

Foreground: `#A9B7C6` (light blue-gray). Background: `#262626` (dark gray).
Fallback background: `#1b1918` (warm near-black).

## Key Colors for Configuring New Software

| Role | Hex | Where |
|------|-----|-------|
| Editor background | `#2b2b2b` | Neovim (darcula_jtk) |
| Terminal background | `#262626` | XTerm/Xresources |
| Normal text | `#a9b7c6` | Everywhere |
| Keywords/accent | `#c57825` | Neovim, tmux (colour166) |
| Selection | `#214283` | Neovim visual mode |
| Blue accent | `#407ee7` | ANSI blue, i3 focus: `#072584` |
| Strings/success | `#5e8759` (vim) / `#5ab738` (term) | |
| Errors | `#f22c40` (term) / `#ee829f` (i3 urgent) | |

## Rules for AI Agents

1. **Always dark theme** — target `#2b2b2b` or `#262626` backgrounds
2. **Text color `#a9b7c6`** — NOT pure white
3. **No `set termguicolors` in Neovim** — uses 256-color cterm values
4. **256-color TERM** — `screen-256color` in tmux, `xterm-256color` outside
5. **Bold does NOT change color** — `intensityStyles: false`
6. **Do not "correct" the warm tint** — it's intentional display calibration
7. **No ICC profiles** without asking
8. **NVIDIA Full RGB (0-255)** — never limited range
9. **Font preference**: Source Code Pro > Bitstream Vera Sans Mono > DejaVu Sans Mono
10. **HiDPI**: DPI is 220, scale UI accordingly

## File Inventory

```
display-colors/
  SPEC.md              — this file
  apply.sh             — one-shot installer script
  set_gamma_ramp.py    — X11 gamma LUT tool (the core engine)
```

## Temperature Keybindings (i3)

`$mod+s` enters display mode, then press 1-0:

| Key | Temperature | Description |
|-----|-------------|-------------|
| 1 | 2700K | Very warm (night) |
| 2 | 3000K | |
| 3 | 3300K | |
| 4 | 3600K | |
| **5** | **3900K** | **Default** |
| 6 | 4200K | |
| 7 | 4500K | |
| 8 | 4800K | |
| 9 | 5100K | |
| 0 | 5500K | Cool (near daylight) |

All keybindings preserve the gamma 1.0:1.2:1.4 and full brightness.
