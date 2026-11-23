#!/usr/bin/env python3
"""
Set a custom X11 gamma ramp combining color temperature,
per-channel gamma correction, and brightness.

Usage:
  python3 set_gamma_ramp.py [temp_K] [gamma_r] [gamma_g] [gamma_b] [brightness]
  python3 set_gamma_ramp.py 3900 1.0 1.2 1.4 1.0
  python3 set_gamma_ramp.py reset
"""

import ctypes
import math
import sys

libx11 = ctypes.cdll.LoadLibrary('libX11.so.6')
libxrandr = ctypes.cdll.LoadLibrary('libXrandr.so.2')

class XRRScreenResources(ctypes.Structure):
    _fields_ = [
        ("timestamp", ctypes.c_ulong),
        ("configTimestamp", ctypes.c_ulong),
        ("ncrtc", ctypes.c_int),
        ("crtcs", ctypes.POINTER(ctypes.c_ulong)),
        ("noutput", ctypes.c_int),
        ("outputs", ctypes.POINTER(ctypes.c_ulong)),
        ("nmode", ctypes.c_int),
    ]

class XRRCrtcGamma(ctypes.Structure):
    _fields_ = [
        ("size", ctypes.c_int),
        ("red", ctypes.POINTER(ctypes.c_ushort)),
        ("green", ctypes.POINTER(ctypes.c_ushort)),
        ("blue", ctypes.POINTER(ctypes.c_ushort)),
    ]

libx11.XOpenDisplay.restype = ctypes.c_void_p
libx11.XOpenDisplay.argtypes = [ctypes.c_char_p]
libx11.XDefaultScreen.restype = ctypes.c_int
libx11.XRootWindow.restype = ctypes.c_ulong
libxrandr.XRRGetScreenResourcesCurrent.restype = ctypes.POINTER(XRRScreenResources)
libxrandr.XRRGetScreenResourcesCurrent.argtypes = [ctypes.c_void_p, ctypes.c_ulong]
libxrandr.XRRGetCrtcGammaSize.restype = ctypes.c_int
libxrandr.XRRGetCrtcGammaSize.argtypes = [ctypes.c_void_p, ctypes.c_ulong]
libxrandr.XRRAllocGamma.restype = ctypes.POINTER(XRRCrtcGamma)
libxrandr.XRRAllocGamma.argtypes = [ctypes.c_int]
libxrandr.XRRSetCrtcGamma.argtypes = [ctypes.c_void_p, ctypes.c_ulong, ctypes.POINTER(XRRCrtcGamma)]
libxrandr.XRRFreeGamma.argtypes = [ctypes.POINTER(XRRCrtcGamma)]


def temp_to_rgb(temp_k):
    """Blackbody color temperature to RGB (Tanner Helland algorithm)."""
    temp = temp_k / 100.0
    if temp <= 66:
        r = 1.0
    else:
        r = max(0.0, min(1.0, 1.292936186 * ((temp - 60) ** -0.1332047592)))
    if temp <= 66:
        g = max(0.0, min(1.0, 0.3900815788 * math.log(temp) - 0.6318414438))
    else:
        g = max(0.0, min(1.0, 1.129890861 * ((temp - 60) ** -0.0755148492)))
    if temp >= 66:
        b = 1.0
    elif temp <= 19:
        b = 0.0
    else:
        b = max(0.0, min(1.0, 0.5432067891 * math.log(temp - 10) - 1.19625409))
    return r, g, b


def set_gamma(temp_k=6500, gamma_r=1.0, gamma_g=1.0, gamma_b=1.0, brightness=1.0):
    tr, tg, tb = temp_to_rgb(temp_k)
    print(f"Temp {temp_k}K -> RGB: ({tr:.4f}, {tg:.4f}, {tb:.4f})")
    print(f"Gamma: {gamma_r}:{gamma_g}:{gamma_b}, Brightness: {brightness}")

    display = libx11.XOpenDisplay(None)
    if not display:
        print("ERROR: Cannot open display"); sys.exit(1)

    screen = libx11.XDefaultScreen(display)
    root = libx11.XRootWindow(display, screen)
    res = libxrandr.XRRGetScreenResourcesCurrent(display, root)
    if not res:
        print("ERROR: Cannot get screen resources"); sys.exit(1)

    for i in range(res.contents.ncrtc):
        crtc_id = res.contents.crtcs[i]
        size = libxrandr.XRRGetCrtcGammaSize(display, crtc_id)
        if size <= 0:
            continue

        gamma = libxrandr.XRRAllocGamma(size)
        for j in range(size):
            x = j / (size - 1) if size > 1 else 0
            r = max(0.0, min(1.0, brightness * tr * (x ** gamma_r)))
            g = max(0.0, min(1.0, brightness * tg * (x ** gamma_g)))
            b = max(0.0, min(1.0, brightness * tb * (x ** gamma_b)))
            gamma.contents.red[j] = int(r * 65535)
            gamma.contents.green[j] = int(g * 65535)
            gamma.contents.blue[j] = int(b * 65535)

        libxrandr.XRRSetCrtcGamma(display, crtc_id, gamma)
        libxrandr.XRRFreeGamma(gamma)
        print(f"  CRTC[{i}] (0x{crtc_id:x}): set {size}-entry ramp")

    libx11.XCloseDisplay(display)
    print("Done.")


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "reset":
        set_gamma(6500, 1.0, 1.0, 1.0, 1.0)
    else:
        temp = int(sys.argv[1]) if len(sys.argv) > 1 else 3900
        gr = float(sys.argv[2]) if len(sys.argv) > 2 else 1.0
        gg = float(sys.argv[3]) if len(sys.argv) > 3 else 1.2
        gb = float(sys.argv[4]) if len(sys.argv) > 4 else 1.4
        br = float(sys.argv[5]) if len(sys.argv) > 5 else 1.0
        set_gamma(temp, gr, gg, gb, br)
