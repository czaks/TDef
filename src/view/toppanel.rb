require "view/subscreen"

module TDef
  module View
    # Top panel shows current game stats, like lifes left,
    # score and money.
    # @final
    class TopPanel < Subscreen
      def initialize
        @start = [0, 0]
        @size = [800, 40]
        super
      end
      
      # Method to draw the top bar.
      def draw
	super
      end
      
      # We don't need to handle events here, there's
      # nothing to click
      def handle_event(event, clicked = false)
      end
    end
  end
end
