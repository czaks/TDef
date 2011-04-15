require "internalscreen"

module TDef
  module View
    # The end game screen
    # @final
    class EndGameScreen < InternalScreen
      # Draw the screen.
      def draw
      end
      
    private
      # Poll constantly for events and react apropriately.
      def single_step
      end
    end
  end
end
