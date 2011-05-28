require "model/monster"

module TDef
  module Units
    # Worm - normal HP, normal speed
    class Worm < Model::Monster
      def image;                "images/monsters/worm.jpg"                end
      def image_dimensions;        [40,40]                                        end
      def max_hp;                40                                        end
      def speed;                0.08                                        end
      def wavecost;                1                                        end
      def min_wave;                1                                        end
      def score;                100                                        end
      def cash;                        20                                        end
    end
    
    # Tank - high HP, normal speed
    class Tank < Model::Monster
      def image;                "images/monsters/tank.jpg"                end
      def image_dimensions;        [40,40]                                        end
      def max_hp;                90                                        end
      def speed;                0.07                                        end
      def wavecost;                1.9                                        end
      def min_wave;                2                                        end
      def score;                250                                        end
      def cash;                        55                                        end
    end
    
    # Rabbit - normal HP, high speed
    class Rabbit < Model::Monster
      def image;                "images/monsters/rabbit.jpg"                end
      def image_dimensions;        [40,40]                                        end
      def max_hp;                45                                        end
      def speed;                0.16                                        end
      def wavecost;                2.2                                        end
      def min_wave;                4                                        end
      def score;                260                                        end
      def cash;                        60                                        end
    end
    
    # Boss - high HP, high speed
    class Boss < Model::Monster
      def image;                "images/monsters/boss.jpg"                end
      def image_dimensions;        [40,40]                                        end
      def max_hp;                130                                        end
      def speed;                0.12.                                        end
      def wavecost;                6.2                                        end
      def min_wave;                7                                        end
      def score;                1000                                        end
      def cash;                        100                                        end
    end
  end
end