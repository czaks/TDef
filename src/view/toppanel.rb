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
        Screen.font.draw_blended_utf8(@surface, "MONEY: #{Game.player.cash}$", 10, 9, 0, 0, 0)
        Screen.font.draw_blended_utf8(@surface, "SCORE: #{Game.player.score}", 260, 9, 0, 0, 0)
        Screen.font.draw_blended_utf8(@surface, "LIFES: #{Game.player.lifes}", 500, 9, 0, 0, 0)
        Screen.font.draw_blended_utf8(@surface, Game.paused? ? "UNPAUSE" : "PAUSE", Game.paused? ? 603 : 617, 9, 0, 0, 0)
        Screen.font.draw_blended_utf8(@surface, "QUIT", 725, 9, 0, 0, 0)
        @surface.draw_rect(600,0,100,40,Screen.handle.format.mapRGB( 0, 0, 0))
        @surface.draw_rect(700,0,100,40,Screen.handle.format.mapRGB( 0, 0, 0))
      end
      
      # We don't need to handle events here, there's
      # nothing to click
      def handle_event(event, clicked = false)
        if clicked == true
          if event[0] >= 600 and event[0] < 700
            unless Game.paused?
	      Game.pause
	    else
	      Game.unpause
	    end
          end
          if event[0] >= 700 and event[0] <800
            Game.stop
          end
        end
      end
    end
  end
end
