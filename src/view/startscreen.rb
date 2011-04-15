require "internalscreen"

module TDef
  module View
    # A start screen.
    # @final
    class StartScreen < InternalScreen
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