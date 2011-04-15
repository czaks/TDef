require "subscreen"

module TDef
  module View
    # A very simple subscreen made just to do nothing and go with the changes
    # that are directed by the InternalScreen.
    # @final
    class BasicSubscreen < Subscreen
      # No direct drawing.
      def draw
	raise NoMethodError, "`draw' method is not available in BasicSubscreen class"
      end
      
      # No receiving of events.
      def handle_event
	raise NoMethodError, "`handle_event' method is not available in BasicSubscreen class"
      end
    end
  end
end