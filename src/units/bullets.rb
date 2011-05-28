require "model/bullet"

module TDef
  module Units
    # BasicBullet is shot by *ShootingTower* and *EliteShootingTower*
    class BasicBullet < Model::Bullet
      def image;		"images/bullets/basicbullet.jpg"	end
      def image_dimensions;	[10,10]					end
      def speed;		0.14					end
    end
    
    # Rocket is shot by *RocketTower* and *EliteRocketTower*
    class Rocket < Model::Bullet
      def image;		"images/bullets/rocket.jpg"		end
      def image_dimensions;	[10,10]					end
      def speed;		0.07					end
    end
    
    # PoisoningBullet is shot by *PoisoningTower*
    class PoisoningBullet < Model::Bullet
      def image;		"images/bullets/poisonbullet.jpg"	end
      def image_dimensions;	[10,10]					end
      def speed;		0.12					end
        
      def finished
        destination.poisoned = 1 if destination.alive
        super
      end
    end
    
    # IceBullet is shot by *FreezingTower* and *EliteFreezingTower*
    class IceBullet < Model::Bullet
      def image;		"images/bullets/icebullet.jpg"	end
      def image_dimensions;	[10,10]					end
      def speed;		0.12					end
        
      def finished
        destination.frozen = 1 if destination.alive
        super
      end
    end
  end
end