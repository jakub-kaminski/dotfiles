-- Force the KTMicro KT USB Audio dongle to S16_LE.
-- The device advertises S24_3LE on Altset 2, but the hardware mangles
-- the byte-packed 24-bit stream into white noise. S16_LE (Altset 1) works.
table.insert(alsa_monitor.rules, {
  matches = {
    {
      { "node.name", "matches", "alsa_output.usb-KTMicro_KT_USB_Audio*" },
    },
    {
      { "node.name", "matches", "alsa_input.usb-KTMicro_KT_USB_Audio*" },
    },
  },
  apply_properties = {
    ["audio.format"] = "S16LE",
    ["audio.rate"] = 48000,
  },
})
