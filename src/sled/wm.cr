module Sled
  module WM
    include X11

    def self.start_wm
      dpy = Display.new
      scr = dpy.default_screen_number
      root = dpy.default_root_window

      dpy.select_input root,
        ButtonPressMask | ButtonReleaseMask |
        ButtonMotionMask | KeyPressMask | KeyReleaseMask | Mod4Mask

      dpy.grab_key(X11.string_to_keysym("D").to_i, Mod4Mask.to_u32, root, true, X11::C::GrabModeAsync, X11::C::GrabModeAsync)

      loop do
        ev = dpy.next_event
        case ev
        when KeyEvent
          if ev.press? && ev.sub_window != None
            File.write("~/test.txt", "#{ev.type}, #{ev.press?}, #{ev.sub_window}")
          else
            File.write("~/test2.txt", "#{ev.type}, #{ev.press?}, #{ev.sub_window}")
          end
        end
      end

      dpy.destroy_window root
      dpy.close
      0
    end
  end
end
