require "subscreen"

module TDef
  module View
    # Top panel shows current game stats, like lifes left,
    # score and money.
    # @final
    class TopPanel < Subscreen
      # Method to draw the top bar.
      def draw
      end
      
      # We don't need to handle events here, there's
      # nothing to click
      def handle_event(event)
      end
    end
  end
end
