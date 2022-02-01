require "x11"
require "./sled/*"

at_exit { GC.collect }

module Sled; end

Sled::WM.start_wm
