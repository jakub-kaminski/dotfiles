rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.usb-KTMicro_KT_USB_Audio_2021-04-13-0000-0000-0000--00.analog-stereo" },
    },
  },
  apply_properties = {
    ["priority.driver"]  = 2000,
    ["priority.session"]  = 2000,
  },
}

table.insert(alsa_monitor.rules, rule)
