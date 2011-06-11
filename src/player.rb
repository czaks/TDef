module TDef
  # A final class. Defines what the player can do.
  # @final
  class Player
    attr_accessor :score, :cash, :lifes
    
    def initialize
      @score = 0
      @cash = Config.money_at_start
      @lifes = Config.lifes_at_start
    end
    
    # Buys a tower. position is a pair of the grid coordinates.
    def buy_tower(tower_class, position)
    end
    
    def sell_tower(tower)
    end
      
    def upgrade_tower(new_class, old_tower)
    end
    
    # Triggers a next wave by user.
    def next_wave()
    end
    
    # Checks whether the player can afford a tower of _tower_class_.
    def affords?(tower_class)
    end
  end
end