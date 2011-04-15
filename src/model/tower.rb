require "gameobject"
require "difficulty"

require "units/towers"

module TDef
  module Model    
    # A base abstract tower class. Towers are able to kill monsters
    # by shooting the bullets. To create a tower, please use the
    # *Player* interface - it's the only way to build a tower and
    # pay for it.
    # @abstract
    class Tower < GameObject
      class << self
	# Returns an array with all towers available.
	def get_all
	end
	
	# Returns an array with all basic towers
	def get_all_basic
	  get_all_upgrades Tower
	end
	
	# Returns an array with all towers which are derived from
	# the _tower_class_
	def get_all_upgrades(tower_class)
	end
      end
      
      # Sholud return a human-readable name of the tower.
      def name
      end
      
      # The tower's build cost or upgrading cost, if it's a second
      # or higher level tower.
      # @virtual
      def cost
      end
      
      # Damage that we can deal with the bullets (HP).
      # @virtual
      def damage
      end
      
      # Range of the tower, how far away on the grid are we able to
      # attack.
      # @virtual
      def range
      end
      
      # Time (in cycles) that we have to wait after a shot until we
      # can fire again
      # @virtual
      def reload_time
      end
      
      # This function, when overloaded, should return a class of its
      # bullets
      # @virtual
      def bullet_class
      end
      
      # The tower "movement". Once per cycle. Actually this function
      # works by searching for monsters in its range and when it finds
      # any, it evaluates the _Tower#shoot_ method.
      def move
      end
      
    private
      # Time that we have to wait for the next bullet.
      attr_accessor :bullet_waittime
      
      # Returns _true_ if the monster is close enough to shot it.
      def has_in_range?(monster)
      end

      # Shoots the monster with a bullet. This function is evaluated
      # automatically, from the move method.
      def shoot(monster)
      end
    end
  end
end