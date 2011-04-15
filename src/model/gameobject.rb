module TDef
  module Model
    # Base class for all the game objects.
    # @abstract
    class GameObject
      # Initializer. Creates some game object at position on the grid.
      # It's not a good way to create new objects using constructors,
      # you'd better use *Scene*, or even *Player* if possible.
      def initialize (position)
      end
      
      # Image representing the object. Should be overloaded.
      # @virtual
      def image
      end
      
      # Image dimensions. It's important to set it to a correct numbers
      # in order to make the engine use it's center as the main point
      # (= the position). The function should return a pair, that is
      # [w,h], which represents the image size in pixels.
      # @virtual
      def image_size
      end
      
      # Current position, a pair identifying a grid field where the
      # object does reside. Can be floating-point, unless the object
      # is a tower.
      attr_accessor :position
    end
  end
end