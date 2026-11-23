rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20190809-00.analog-stereo" },
    },
  },
  apply_properties = {
    ["priority.driver"]  = 2000,
    ["priority.session"]  = 2000,
  },
}

table.insert(alsa_monitor.rules, rule)
