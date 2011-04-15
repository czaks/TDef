module TDef
  module View
    # Abstract class describing part of the window.
    class Subscreen
      # Drawing method to overload. Use SDL.
      # @virtual
      def draw
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
      # @virtual
      def handle_event(event)
      end
    end
  end
end