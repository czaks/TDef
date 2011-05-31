require "gameobject"

module TDef
  module Model    
    class Placement < GameObject
      attr_accessor :tower_class
      
      def initialize(tower_class)
        @tower_class = tower_class
        new
        super([0,0])
      end
      
      def image
        tower_class.new([0,0]).image
      end
      
      def image_size
        tower_class.new([0,0]).image_size
      end
    end
  end
end
