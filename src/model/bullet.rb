require "model/gameobject"
require "game"

module TDef
  module Model    
    # A bullet is being constructed by a tower. It is made
    # using a _Tower#move_ (searching for monsters), then
    # checking by _Tower#has_in_range?_ and finally by
    # _Tower#shoot_, which actually redirects to
    # _Scene#create_bullet_, which calls the constructor.
    # Afterwards, the tower isn't able to shoot for
    # _Tower#bullet_waittime_ cycles. The bullet moves using
    # the _Bullet#move_ method, when it gets to a place, it
    # calls _Bullet#finished_. See comment under this method.
    # This class is abstract, please extend it - you have
    # to at least write 3 methods (image, image_dimensions
    # and speed).
    # @abstract
    class Bullet < GameObject
      # Please don't construct a bullet directly. Use
      # _Tower#shoot_.
      def initialize(source_tower, destination_monster)
        @source = source_tower
        @destination = destination_monster
        
        @damage = source_tower.damage
        
        super(@source.position.dup)
      end
      
      # Speed of the bullet. In one field of grid per second.
      # Please use the small floating point numbers.
      # @virtual
      def speed
      end
      
      # Bullet movement, it's run once per a cycle.
      def move
        if !destination.alive
          Game.scene.remove_object self
        else
          d_x, d_y = *destination.position
          b_x, b_y = *position
          
          if d_x.round == b_x.round and d_y.round == b_y.round
            finished
          else
            vlen = Math.sqrt((d_x - b_x)*(d_x - b_x) + (d_y - b_y)*(d_y - b_y))
	    
	    m_x = (d_x - b_x)*speed/vlen
	    m_y = (d_y - b_y)*speed/vlen
	    
	    position[0] += m_x
	    position[1] += m_y
          end
        end
      end
      
    private
      # Source tower
      attr_reader :source
      
      # Attacked monster, located at _Bullet#destination_position_
      attr_reader :destination
      
      # The damage the bullet is going to take away from monster.
      attr_reader :damage
      
      # The position (on the grid) the bullet is going to go.
      attr_reader :destination_position
      
      # When bullet gets to a place, it can take some HP from
      # a monster, or even kill him and get some money and
      # points. Then, a bullet can be safely removed. Consult
      # classes *Scene* and *Player*.
      # If you make a poisonous or icy bullet, you can overload
      # this method, but remember to use super to call the
      # parent!
      def finished
        destination.hp -= damage
	Game.scene.remove_object self
      end
    end
  end
end

require "units/bullets"