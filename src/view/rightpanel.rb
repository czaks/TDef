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
	
	@towers = nil
	@upgrades = nil
	@base_tower_class = nil
	
	@t_onclick = {}
        super
      end
      
      def draw_tower i, off_y, onclick = :buy
	color = [0, 0, 0]
	color = [0x88, 0x88, 0x88] if onclick != :extended and !Game.player.affords? i
	Screen.font.draw_blended_utf8(@surface, i.new.name, 38, off_y+2, *color)
	Screen.smallfont.draw_blended_utf8(@surface, "Cost: "+i.new.cost.to_s+"$", 44, off_y+25, *color)
	if onclick == :extended
	Screen.smallfont.draw_blended_utf8(@surface, "Damage: "+i.new.damage.to_s, 44, off_y+38, *color)
	Screen.smallfont.draw_blended_utf8(@surface, "Range: "+i.new.range.to_s, 44, off_y+51, *color)
	Screen.smallfont.draw_blended_utf8(@surface, "Reload Time: "+i.new.reload_time.to_s, 44, off_y+64, *color)
	end
	Image.draw(i.new.image, @surface, 0, off_y)
	
	if onclick != :extended
	  @onclick[[0, off_y, 200, off_y+40]] = proc do
	    if Game.player.affords? i
	      if onclick == :buy
		Game.scene.create_placement(i)
	      elsif onclick == :sell and Game.scene.selected_tower
		Game.player.upgrade_tower i, Game.scene.selected_tower
	      end
	    end
	  end
	end
      end
      
      # Method to draw the panel.
      def draw
	super
	@onclick = {}
	Screen.font.draw_blended_utf8(@surface, "WAVE: #{Game.wave.number}", 6, 9, 0, 0, 0)
	if Game.player.can_trigger_next_wave?
	  Screen.font.draw_blended_utf8(@surface, "NEXT", 122, 9, 0, 0, 0)
	  @onclick[[100, 0, 200, 40]] = proc do
	    Game.player.next_wave
	  end
	else
	  Screen.font.draw_blended_utf8(@surface, "NEXT", 122, 9, 0x88, 0x88, 0x88)
	end
	Screen.font.draw_blended_utf8(@surface, "BUILDINGS:", 44, 49, 0, 0, 0)
	off_y = 80
	
	@towers = Model::Tower.get_all_basic unless @towers
	@towers.each do |i|
	  draw_tower i, off_y, :buy
	  off_y += 40 
	end
	
	if Game.scene.selected_tower
	  if @base_tower_class != Game.scene.selected_tower.class
	    @base_tower_class = Game.scene.selected_tower.class
	    @upgrades = Model::Tower.get_all_upgrades @base_tower_class
	  end
	  
	  if @upgrades.length > 0
	    Screen.font.draw_blended_utf8(@surface, "UPGRADES:", 45, off_y+9, 0, 0, 0)

	    off_y += 40
	  end
	  
	  @upgrades.each do |i|
	    draw_tower i, off_y, :sell
	    off_y += 40
	  end
	  
	  Screen.font.draw_blended_utf8(@surface, "SELL", 78, off_y+9, 0, 0, 0)
	  @onclick[[0, off_y, 200, off_y+40]] = proc do
	    Game.player.sell_tower Game.scene.selected_tower
	  end
	  
	  Screen.font.draw_blended_utf8(@surface, "SELECTED:", 47, 369, 0, 0, 0)
	  off_y = 400
	  draw_tower Game.scene.selected_tower.class, off_y, :extended
	  
	end
	
	Screen.font.draw_blended_utf8(@surface, "TDef", 10, 489, 0, 0, 0)
	Screen.smallfont.draw_blended_utf8(@surface, "Marcin Łabanowski (131565)", 10, 509, 0, 0, 0)
	Screen.smallfont.draw_blended_utf8(@surface, "Adam Łaguna (131566)", 10, 522, 0, 0, 0)
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
	
	@t_onclick = @onclick
      end
      
      # Handle the events (button clicks, etc.)
      def handle_event(event, clicked = false)
	if clicked
	  x, y = *event
	  
	  @t_onclick.each do |key,block|
	    x0, y0, x1, y1 = *key
	    if x >= x0 and y >= y0 and x < x1 and y < y1
	      block[]
	    end
	  end
	end
      end
    end
  end
end
