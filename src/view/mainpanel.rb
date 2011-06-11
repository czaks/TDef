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
      
      def grids_to_pixels a
	x,y = *a
	
	x *= Config.part_size[0]
	y *= Config.part_size[1]
	
	x += Config.part_size[0] / 2
	y += Config.part_size[1] / 2
	
	[x,y]
      end
      
      def pixels_to_grids a
	x,y = *a
	x *= 1.0
	y *= 1.0
	
	x -= Config.part_size[0] / 2
	y -= Config.part_size[0] / 2
	
	x /= Config.part_size[0]
	y /= Config.part_size[1]
	
	[x,y]
      end
      
      # Method to draw the screen.
      def draw
	super
	
	Config.map_size[1].times do |y|
          Config.map_size[0].times do |x|
            @surface.draw_rect(Config.part_size[0]*x,Config.part_size[1]*y,Config.part_size[0],Config.part_size[1],Screen.handle.format.mapRGB( 0, 0, 0))
          end
        end
	
	Game.scene.get_drawable_objects.each do |i|
	  position = grids_to_pixels(i.position)
	  position[0] -= i.image_size[0]/2
	  position[1] -= i.image_size[1]/2
	  
	  Image.draw(i.image, @surface, *position)
	end
      end
      
      # Handle the events (mouse clicks, etc.)
      def handle_event(event, clicked = false)
      end
    end
  end
end