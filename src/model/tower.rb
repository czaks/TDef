require "gameobject"
require "game"

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
          ObjectSpace.each_object.to_a.select { |a| a.class == Class && a.ancestors.include?(Tower) && a != Tower }
        end
        
        # Returns an array with all basic towers
        def get_all_basic
          get_all_upgrades Tower
        end
        
        # Returns an array with all towers which are derived from
        # the _tower_class_
        def get_all_upgrades(tower_class)
          ObjectSpace.each_object.to_a.select { |a| a.class == Class && a.superclass == tower_class }
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
        if @bullet_waittime
          bullet_waittime -= 1
        else
          mons = Game.scene.monsters.select do |m|
            t_x, t_y = *location
            m_x, m_y = *m.location
            
            range <= Math.sqrt((m_x-t_x) * (m_x-t_x) + (m_y-t_y) * (m_y-t_y))
          end
          
          mons.sort { |a,b| a.location[0] <=> b.location[0] }

          if monster = mons.pop
            bullet_waittime = reload_time
            Game.scene.create_bullet self, monster
          end
        end
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