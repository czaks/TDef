require "config"

module TDef
  # A final, static class defining operations on the map. The methods
  # are low-level - this class is a grid container and helper. It doesn't
  # use the *Player* class, so it doesn't take cash from player - to add
  # a tower, please use the higher-level *Player* class.
  # @final
  class Scene
    def initialize
    end
    
    # Returns a direction in which there is a shortest path.
    #
    # _from_ is a pair of grid coordinates, if _check_ is defined and
    # also a pair, then try to simulate some object at this point.
    # This is done in order to check if we can put a tower at an
    # arbitary place.
    def shortest_path_from(from, check=nil)
    end
    
    # Returns a pair being the size of the grid.
    def map_size()
      Config.map_size
    end
    
    def create_monster(monster_class)
    end
    
    # Creates a tower of the given class. Position is a pair of grid
    # coordinates.
    def create_tower(tower_class, position)
    end
    
    def upgrade_tower(new_class, old_tower)
    end
    
    # Removes any sort of *GameObject* from the class.
    def remove_object(gameobject)
    end
    
    def create_bullet(source_tower, target_monster)
    end
    
    # Creates a tower placeholder imitating a tower from _tower_class_.
    def create_placement(tower_class)
    end
    
    # This method is used to extract the drawable objects by the
    # *MainPanel* class (part of the *GameScreen*).
    #
    # It returns an array of *GameObject*s, first coming the *Monster*s,
    # then *Tower*s, then *Bullet*s, and *Placement* at the end.
    def get_drawable_objects()
    end
    
    # A tower selected at the moment. _nil_, if nothing's selected.
    attr_reader :selected_tower
    
    # A placeholder (*Placement*) being used now to create a tower.
    # _nil_, if that's not the case.
    attr_reader :placed_tower
    
  private
    # A two dimensional array containing towers in order to make requests
    # faster
    attr_reader :towers
    
    # An array containing all objects visible on the map.
    attr_reader :objects
  end
end