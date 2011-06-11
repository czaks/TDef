require "sdl"

module TDef
  module View
    # Abstract class describing part of the window.
    class Subscreen
      def initialize
        @surface = SDL::Surface.new(SDL::DOUBLEBUF, size[0], size[1], Screen.handle)
      end
      
      # Drawing method to overload. Use SDL.
      # @virtual
      def draw
        @surface.fill_rect(0, 0, size[0]-1, size[1]-1, Screen.handle.format.mapRGB(255,255,255))
        @surface.draw_rect(0, 0, size[0]-1, size[1]-1, Screen.handle.format.mapRGB(  0,  0,  0))
      end
      
      # The parent screen, variable set by it when issuing _add_subscreen_
      attr_accessor :parent_screen
      
      # Pair of pixel coordinates, where the window starts. Variable set by
      # _Screen#add_subscreen_.
      attr_accessor :start
      
      # Width and height of the subwindow in pixels. Variable set by
      # _Screen#add_subscreen_.
      attr_accessor :size
      
      # Called everytime unless _Screen#get_event_ has been overloaded
      # Event is a pair of coordinates. Clicked denotes the clicked state.
      # @virtual
      def handle_event(event, clicked = false)
        
      end
      
      attr_accessor :surface
    end
  end
end