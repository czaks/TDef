require "view/subscreen"

module TDef
  module View
    # Right panel handler. It has the important buttons
    # for buying, selling and upgrading towers among others.
    # @final
    class RightPanel < Subscreen
      def initialize
        @start = [600, 40]
        @size = [200, 560]
        super
      end
      
      # Method to draw the panel.
      def draw
      super
      Screen.font.draw_blended_utf8(@surface, "WAVE: 5", 10, 9, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "NEXT", 122, 9, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "BUILDINGS:", 44, 49, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "SHOOTING", 50, 89, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "ROCKET", 50, 129, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "FREEZING", 50, 169, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "UPGRADES:", 45, 209, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "SELL", 78, 289, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "SELECTED:", 47, 329, 0, 0, 0)
      Screen.font.draw_blended_utf8(@surface, "TDef", 10, 489, 0, 0, 0)
      @surface.draw_rect(0,0,100,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(100,0,100,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,40,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,80,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,120,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,160,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,200,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,240,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,280,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,320,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,360,200,40,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,400,200,80,Screen.handle.format.mapRGB( 0, 0, 0))
      @surface.draw_rect(0,480,200,80,Screen.handle.format.mapRGB( 0, 0, 0))
      end
      
      # Handle the events (button clicks, etc.)
      def handle_event(event, clicked = false)
	#p [event, clicked]
      end
    end
  end
end
