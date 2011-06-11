require "view/subscreen"

module TDef
  module View
    # Right panel handler. It has the important buttons
    # for buying, selling and upgrading towers among others.
    # @final
    class RightPanel < Subscreen
      def initialize
        @start = [600, 40]
        @size = [200, 560]
        super
      end
      
      # Method to draw the panel.
      def draw
	super
      end
      
      # Handle the events (button clicks, etc.)
      def handle_event(event, clicked = false)
	#p [event, clicked]
      end
    end
  end
end
