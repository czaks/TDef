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
      Game.scene.selected_tower = Game.scene.create_tower(tower_class, position)
      @cash -= Game.scene.selected_tower.cost
    end
    
    def sell_tower(tower)
      @cash += tower.cost * 2 / 3
      Game.scene.selected_tower = nil
      Game.scene.remove_object tower
    end
      
    def upgrade_tower(new_class, old_tower)
      Game.scene.selected_tower = Game.scene.upgrade_tower(new_class, old_tower)
      @cash -= Game.scene.selected_tower.cost
    end
    
    def can_trigger_next_wave?()
      Game.wave.last_wave_ended
    end
    
    # Triggers a next wave by user.
    def next_wave()
      Game.wave.start_next
    end
    
    # Checks whether the player can afford a tower of _tower_class_ (maybe upgrading?).
    def affords?(tower_class)
      @cash >= tower_class.new.cost
    end
  end
end