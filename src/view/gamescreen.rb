require "view/screen"

require "view/mainpanel"
require "view/rightpanel"
require "view/toppanel"

module TDef
  module View
    # The game screen.
    # @final
    class GameScreen < Screen
      def initialize
	super
	
	add_subscreen MainPanel.new
	add_subscreen RightPanel.new
	add_subscreen TopPanel.new
      end
      
      # Draw the screen and load the subwindows.
      def draw
	super
      end
      
    private
      # Poll constantly for events and react apropriately.
      def single_step
	e = get_event
	
	case e
	when SDL::Event2::Quit
	  Game.stop
	when SDL::Event::Active # Let's draw the main screen as soon as possible
	  draw
	end
      end
    end
  end
end
