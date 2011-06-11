require "view/subscreen"

module TDef
  module View
    # Main panel handler. Shows the grid, the towers, the 
    # monsters, etc.
    # @final
    class MainPanel < Subscreen
      def initialize
        @start = [0, 40]
        @size = [600, 560]
        super
      end
      
      # Method to draw the screen.
      def draw
	super
      end
      
      # Handle the events (mouse clicks, etc.)
      def handle_event(event, clicked = false)
      end
    end
  end
end