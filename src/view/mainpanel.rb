require "view/subscreen"
require "model/tower"

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
	
	if Game.scene.selected_tower
	  position = grids_to_pixels(Game.scene.selected_tower.position)
	  
	  @surface.drawFilledCircle(position[0], position[1], Game.scene.selected_tower.range * Config.part_size[0], Screen.handle.format.mapRGB(0xbb, 0xbb, 0xbb))
	end
	
	position = Config.monsters_start_at
	position[0] += 1
	position = grids_to_pixels(position)
	position[0] -= 20
	position[1] -= 20
	Image.draw("images/arrow.png", @surface, *position)
	
	position = Config.monsters_end_at
	position[0] -= 1
	position = grids_to_pixels(position)
	position[0] -= 20
	position[1] -= 20
	Image.draw("images/arrow.png", @surface, *position)
	
	Config.map_size[1].times do |y|
          Config.map_size[0].times do |x|
            @surface.draw_rect(Config.part_size[0]*x,Config.part_size[1]*y,Config.part_size[0],Config.part_size[1],Screen.handle.format.mapRGB(0x88, 0x88, 0x88))
          end
        end
	
	Game.scene.get_drawable_objects.each do |i|
	  position = grids_to_pixels(i.position)
	  if i.class <= Model::Monster # Drawing HP lines
	    color = Screen.handle.format.mapRGB(0xaa, 0xaa, 0xaa)
	    if i.poisoned
	      color = Screen.handle.format.mapRGB(0xff, 0x00, 0xff)
	    end
	    @surface.draw_line(position[0]-12, position[1]-18, position[0]+12, position[1]-18, color)
	    @surface.draw_line(position[0]-12, position[1]-17, position[0]+12, position[1]-17, color)
	    
	    line_len = i.hp * 24 / i.max_hp
	    
	    color = Screen.handle.format.mapRGB(0x00, 0xff, 0x00)
	    if i.frozen
	      color = Screen.handle.format.mapRGB(0x00, 0xff, 0xff)
	    end
	    @surface.draw_line(position[0]-12, position[1]-18, position[0]-12+line_len, position[1]-18, color)
	    @surface.draw_line(position[0]-12, position[1]-17, position[0]-12+line_len, position[1]-17, color)
	  end
	  position[0] -= i.image_size[0]/2
	  position[1] -= i.image_size[1]/2
	  
	  Image.draw(i.image, @surface, *position)
	end
      end
      
      # Handle the events (mouse clicks, etc.)
      def handle_event(event, clicked = false)
	touching = pixels_to_grids event
	if Game.scene.placed_tower
	  Game.scene.placed_tower.position = touching
	  
	  if clicked
	    if !Game.scene.towers[[touching[0].round, touching[1].round]]
	      Game.moving.synchronize do
		allowed = true
		
		points = Game.scene.monsters.map { |i| i.position.map { |j| j.round } }
		points << Config.monsters_start_at
		
		points.each do |i|
		  if [touching[0].round, touching[1].round] == i
		    allowed = false
		    break
		  end
		  
		  unless Game.scene.shortest_path_from i, [touching[0].round, touching[1].round]
		    allowed = false
		    break
		  end
		end
		Game.player.buy_tower(Game.scene.placed_tower.tower_class, [touching[0].round, touching[1].round]) if allowed
	      end
	    end
	    Game.scene.placed_tower = nil
	  end
	else # Selecting a tower
	  if clicked
	    if (Game.scene.towers[[touching[0].round, touching[1].round]])
	      Game.scene.selected_tower = Game.scene.towers[[touching[0].round, touching[1].round]]
	    else
	      Game.scene.selected_tower = nil
	    end
	  end
	end
      end
    end
  end
end