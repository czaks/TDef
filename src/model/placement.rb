require "model/gameobject"

module TDef
  module Model    
    class Placement < GameObject
      attr_accessor :tower_class
      
      def initialize(tower_class)
        @tower_class = tower_class
        super([-1,-1])
      end
      
      def image
        tower_class.new.image
      end
      
      def image_size
        tower_class.new.image_size
      end
    end
  end
end
