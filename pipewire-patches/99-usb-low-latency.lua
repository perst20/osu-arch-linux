usb_device_name = "alsa_output.usb*"


table.insert(alsa_monitor.rules, {
  matches = {
    {
      -- Matches all sinks.
      { "node.name", "matches", usb_device_name },
    },
  },
  apply_properties = {
    --["node.nick"]              = "My Node",
    --["priority.driver"]        = 100,
    --["priority.session"]       = 100,
    --["node.pause-on-idle"]     = false,
    --["resample.quality"]       = 4,
    --["channelmix.normalize"]   = false,
    --["channelmix.mix-lfe"]     = false,
    --["audio.channels"]         = 2,
    --["audio.format"]           = "S16LE",
    --["audio.rate"]             = 44100,
    --["audio.position"]         = "FL,FR",
    ["api.alsa.period-size"]   = 16,
    --["api.alsa.headroom"]      = 0,
    --["api.alsa.disable-mmap"]  = false,
    ["api.alsa.disable-batch"] = true,
  },
})
