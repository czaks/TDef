require "config"
require "model/placement"
require "thread"

module TDef
  # A final, static class defining operations on the map. The methods
  # are low-level - this class is a grid container and helper. It doesn't
  # use the *Player* class, so it doesn't take cash from player - to add
  # a tower, please use the higher-level *Player* class.
  # @final
  class Scene
    def initialize
      @monsters = []
      @towers = {}
      @bullets = []
      @placed_tower = nil
      @selected_tower = nil
    end
    
    # Returns a direction in which there is a shortest path.
    #
    # _from_ is a pair of grid coordinates, if _check_ is defined and
    # also a pair, then try to simulate some object at this point.
    # This is done in order to check if we can put a tower at an
    # arbitary place.
    def shortest_path_from(from, check=nil)
      dirs = [ [1,0], [0,1], [0,-1], [-1,0] ]
      
      #return [1,0]
      
      unless @cache and @cached_for == towers.keys+[check]
	marked = {}
	marked.default = false

	q = [Config.monsters_end_at]
	first = 0
	
	marked[Config.monsters_end_at] = true
	
	while first < q.size
	  v = q[first]
	  first += 1
	  for i in dirs
	    w = [v[0]+i[0], v[1]+i[1]]
	    next if w != Config.monsters_start_at and w != Config.monsters_end_at and
		  (w[0] < 0 or w[1] < 0 or w[0] >= Config.map_size[0] or w[1] >= Config.map_size[1])
	    next if marked[w] or w == check or towers[w]
	    marked[w] = [-i[0], -i[1] ]
	    q << w
	  end
	end
	
	@cached_for = towers.keys+[check]
	@cache = marked
      end
            
      return @cache[from]
    end
    
    # Returns a pair being the size of the grid.
    def map_size()
      Config.map_size
    end
    
    def create_monster(monster_class)
      monster = monster_class.new(Config.monsters_start_at)
      @monsters << monster
      monster
    end
    
    # Creates a tower of the given class. Position is a pair of grid
    # coordinates.
    def create_tower(tower_class, position)
      tower = tower_class.new(position)
      @towers[position] = tower
      tower
    end
    
    def upgrade_tower(new_class, old_tower)
      new_tower = new_class.new(old_tower.position)
      @towers[old_tower.position] = new_tower
      new_tower
    end
    
    # Removes any sort of *GameObject* from the class.
    def remove_object(gameobject)
      @monsters.delete gameobject
      @towers.delete_if { |a,b| b == gameobject }
      @bullets.delete gameobject
    end
    
    def create_bullet(source_tower, target_monster)
      new_bullet = source_tower.bullet_class.new(source_tower, target_monster)
      @bullets << new_bullet
    end
    
    # Creates a tower placeholder imitating a tower from _tower_class_.
    def create_placement(tower_class)
      @placed_tower = Model::Placement.new(tower_class)
    end
    
    # This method is used to extract the drawable objects by the
    # *MainPanel* class (part of the *GameScreen*).
    #
    # It returns an array of *GameObject*s, first coming the *Monster*s,
    # then *Tower*s, then *Bullet*s, and *Placement* at the end.
    def get_drawable_objects()
      @ary = []
      @ary += @monsters
      @ary += @towers.values
      @ary += @bullets
      @ary << @placed_tower if @placed_tower
      @ary
    end
    
    # A tower selected at the moment. _nil_, if nothing's selected.
    attr_accessor :selected_tower
    
    # A placeholder (*Placement*) being used now to create a tower.
    # _nil_, if that's not the case.
    attr_accessor :placed_tower
 
    # An array containing all monsters visible on the map.
    attr_reader :monsters
    attr_reader :towers
    attr_reader :bullets
  end
end