require "subscreen"

module TDef
  module View
    # A simple subscreen with a simple aim - displaying messages
    # on the game screen.
    # @final
    class MessageBox < Subscreen
      # MessageBox is initialized with a message
      def initialize (message)
      end
      
      # Method to draw the message and buttons
      def draw
      end
      
      # Handle the events (button clicks, etc.)
      def handle_event(event)
      end
    end
  end
end
