require "screen"

module TDef
  module View
    # The game screen.
    # @final
    class GameScreen < Screen
      # Draw the screen and load the subwindows.
      def draw
      end
      
    private
      # Poll constantly for events and react apropriately.
      def single_step
      end
    end
  end
end
