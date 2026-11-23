-- Keep the standalone USB MICROPHONE always active.
-- Without this, PipeWire suspends the source after idle and the first
-- ~300-1000 ms of audio is lost while the stream restarts on push-to-talk,
-- clipping the beginning of dictated phrases in voxtype.
no_suspend_rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_input.usb-USB_MICROPHONE_USB_MICROPHONE_20190809-00.analog-stereo" },
    },
  },
  apply_properties = {
    ["session.suspend-timeout-seconds"] = 0,
  },
}

table.insert(alsa_monitor.rules, no_suspend_rule)
