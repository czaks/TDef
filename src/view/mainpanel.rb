require "view/subscreen"

module TDef
  module View
    # Main panel handler. Shows the grid, the towers, the 
    # monsters, etc.
    # @final
    class MainPanel < Subscreen
      def initialize
        @start = [0, 40]
        @size = [600, 560]
        super
      end
      
      # Method to draw the screen.
      def draw
        super
        Config.map_size[1].times do |y|
          Config.map_size[0].times do |x|
            @surface.draw_rect(Config.part_size[0]*x,Config.part_size[1]*y,Config.part_size[0],Config.part_size[1],Screen.handle.format.mapRGB( 0, 0, 0))
          end
        end
      end
      # Handle the events (mouse clicks, etc.)
      def handle_event(event, clicked = false)
      end
    end
  end
end