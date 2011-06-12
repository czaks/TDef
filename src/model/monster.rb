require "model/gameobject"
require "game"

module TDef
  module Model    
    # A monster base class. The monster aims to get through your
    # defense to go to the right side of the grid.
    # @abstract
    class Monster < GameObject
      class << self
        # Returns array with all monsters available.
        def get_all
          ObjectSpace.each_object.to_a.select { |a| a.class == Class && a.superclass == Monster }
        end
      end
      # Please don't construct a monster directly. To get a massive
      # monster attack, you can see the *Player* class or the *Wave*
      # class. To get one monster, it would be the best to use the
      # *Scene* class.
      def initialize(position=nil)
        super(position)
	if position
	  @alive = 1
	  @hp = max_hp
	  
	  @dir = false
	end
      end
      
      # A boolean value showing whether the object is still alive
      # (on grid) or not.
      attr_accessor :alive
      
      # Remaining hit points of the monster
      attr_accessor :hp
      
      # The monster's max hp
      # @virtual
      def max_hp
      end
      
      # The monster's speed. In one field of grid per second.
      # Please use the small floating point numbers.
      # @virtual
      def speed
      end
      
      # Wavepoints are the points that are exchanged for...
      # monsters that keep coming to your base. For instance
      # 5 wavepoints can allow 5 monsters with wavecost 1 come
      # to your grid, or 2 monsters with wavecost 2 and 1 with
      # 1. This is the wavecost of the monster. You can set it
      # to float, but please don't move it below 1.
      # @virtual
      def wavecost
      end
      
      # Minimal wave number to make the monster appear.
      # @virtual
      def min_wave
      end
      
      # Your score reward for killing the monster
      # @virtual
      def score
      end
      
      # Your cash reward for killing the monster
      # @virtual
      def cash
      end
      
      # Effective speed
      def effective_speed
	if frozen
	  speed / 2
	else
	  speed
	end
      end
            
      # The monster movement. Once per cycle. Monsters move
      # towards _Config.monsters_end_at_ place. 
      def move
	if poisoned
	  @hp = @hp * 40 / 41
	end
	
	if @hp <= 0
	  Game.player.score += score
	  Game.player.cash += cash
	  
	  self.alive = false
	  Game.scene.remove_object self
	end
	finished if Config.monsters_end_at[0] == position[0] and Config.monsters_end_at[1] == position[1]
	return unless self.alive
	
	if !@dir
	  @dir = Game.scene.shortest_path_from position
	  finished if @dir == true
	  return unless self.alive
	  @goal = [position[0].round + @dir[0], position[1].round + @dir[1]]
	else
	  if Game.scene.towers[@goal]
	    @dir = false
	    @position[0] = @position[0].round
	    @position[1] = @position[1].round
	    return
	  end
	  
	  position[0] += @dir[0] * effective_speed
	  position[1] += @dir[1] * effective_speed
	  
	  if (@dir[0] < 0 and position[0] <= @goal[0]) or (@dir[0] > 0 and position[0] >= @goal[0]) or
	     (@dir[1] < 0 and position[1] <= @goal[1]) or (@dir[1] > 0 and position[1] >= @goal[1])
	    
	    @dir = Game.scene.shortest_path_from @goal
	    finished if @dir == true
	    return unless self.alive
	    
	    waitingmove = (position[0]-@goal[0]).abs + (position[1]-@goal[1]).abs
	    @position = @goal
	    @goal = [position[0].round + @dir[0], position[1].round + @dir[1]]
	    @position[0] += waitingmove * @dir[0]
	    @position[1] += waitingmove * @dir[1]
	  end
	end
      end
      
      # Set by an _IceTower#finished_ method. True/False. Makes
      # the monster slower.
      attr_accessor :frozen
      
      # Set by a _PoisonousTower#finished_ method. True/False.
      # Makes the monster lose HP every time a _move_ method is
      # being executed.
      attr_accessor :poisoned
      
    private
      # When one monster comes at a _Config.monsters_end_at_
      # place, a _Monster#finished_ function is executed, which
      # takes one life from player away, a _Monster#alive_ is
      # modified to point to false and *Scene* finally removes
      # the monster from the grid.
      def finished
        if Game.player.lifes <= 0
          Game.stop
        else
          Game.player.lifes -= 1
          self.alive = false
          Game.scene.remove_object self
        end
      end
    end
  end
end

require "units/monsters"