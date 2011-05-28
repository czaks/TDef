require "screen"
require "basicsubscreen"

module TDef
  module View
    # A superclass of the non-game screens.
    # @abstract
    class InternalScreen < Screen
      # Loads BasicSubscreen at the fullscreen.
      def initialize
      end
      
      # Like _Screen#get_event_, but doesn't propagate events to subscreens,
      # since it's not needed. All you need is to extend the *InternalScreen*
      # and overload the private _single_step_ method.
      def get_event
	_get_event
      end
    end
  end
end