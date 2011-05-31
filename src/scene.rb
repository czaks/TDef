require "config"

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
      x,y = *from
      return false if @towers[x, y] or check == from
      return true if from == Config.monsters_end_at
      
      return [1,0]  if shortest_path_from([x+1, y])
      return [-1,0] if shortest_path_from([x-1, y])
      return [0,1]  if shortest_path_from([x, y+1])
      return [0,-1] if shortest_path_from([x, y-1])
      
      return false
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
      @towers[old_tower.position] = tower
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
      @tower.delete gameobject
      @bullets.delete gameobject
    end
    
    def create_bullet(source_tower, target_monster)
      new_bullet = source_tower.bullet_class.new(source_tower, target_monster)
      @bullets << new_bullet
    end
    
    # Creates a tower placeholder imitating a tower from _tower_class_.
    def create_placement(tower_class)
      @placed_tower = Placement.new(tower_class)
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
    attr_reader :selected_tower
    
    # A placeholder (*Placement*) being used now to create a tower.
    # _nil_, if that's not the case.
    attr_reader :placed_tower
    
  private
 
    # An array containing all monsters visible on the map.
    attr_reader :monsters
    attr_reader :towers
    attr_reader :bullets
  end
end