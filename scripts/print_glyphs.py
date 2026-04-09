#!/usr/bin/env python3
"""Print all Nerd Font glyphs with their codepoints and names, one per line."""

import json
import urllib.request

GLYPHNAMES_URL = "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json"

# Known Nerd Font codepoint ranges
RANGES = [
    (0xE000, 0xE00D),    # Pomicons
    (0xE0A0, 0xE0D7),    # Powerline + Extra
    (0xE200, 0xE2A9),    # Font Awesome Extension
    (0xE300, 0xE3E3),    # Weather Icons
    (0xE5FA, 0xE6B5),    # Seti-UI + Custom
    (0xE700, 0xE7C5),    # Devicons
    (0xEA60, 0xEBEB),    # Codicons
    (0xF000, 0xF2E0),    # Font Awesome
    (0xF300, 0xF372),    # Font Logos
    (0xF400, 0xF533),    # Octicons
    (0xF0001, 0xF1AF0),  # Material Design Icons
]

# Build codepoint -> name lookup from Nerd Fonts glyphnames.json
cp_to_name: dict[int, str] = {}
try:
    with urllib.request.urlopen(GLYPHNAMES_URL, timeout=10) as resp:
        data = json.loads(resp.read().decode())
    for name, info in data.items():
        if name == "METADATA":
            continue
        try:
            cp_to_name[int(info["code"], 16)] = name
        except (KeyError, ValueError):
            pass
except Exception as e:
    print(f"# Warning: could not load glyph names ({e})")

for start, end in RANGES:
    for cp in range(start, end + 1):
        try:
            glyph = chr(cp)
            name = cp_to_name.get(cp, "")
            print(f"{glyph}    U+{cp:05X}    {name}")
        except (ValueError, OverflowError):
            pass
