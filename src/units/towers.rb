require "model/tower"
require "units/bullets"


module TDef
  module Units
    # ShootingTower is a cheap and basic tower
    class ShootingTower < Model::Tower
      def image;		"images/towers/shooting.png"		end
      def image_size;		[40,40]					end
      def name;			"Shooting Tower"			end
      def cost;			25					end
      def damage;		5					end
      def range;		1.6					end
      def reload_time;		15					end
      def bullet_class;		BasicBullet				end
    end
    
    # EliteShootingTower is an upgraded ShootingTower
    class EliteShootingTower < ShootingTower
      def image;		"images/towers/eliteshooting.png"	end
      def image_size;		[40,40]					end
      def name;			"Elite Shooting Tower"			end
      def cost;			50					end
      def damage;		10					end
      def range;		1.9					end
      def reload_time;		13					end
      def bullet_class;		BasicBullet				end
    end
    
    # PoisoningTower deals damage to the opponents by poisoning them
    class PoisoningTower < ShootingTower
      def image;		"images/towers/poisoning.png"		end
      def image_size;		[40,40]					end
      def name;			"Poisoning Tower"			end
      def cost;			65					end
      def damage;		15					end
      def range;		1.8					end
      def reload_time;		20					end
      def bullet_class;		PoisoningBullet				end
    end
    
    # RocketTower is a better choice in the later game
    class RocketTower < Model::Tower
      def image;		"images/towers/rocket.png"		end
      def image_size;		[40,40]					end
      def name;			"Rocket Tower"				end
      def cost;			65					end
      def damage;		15					end
      def range;		3.8					end
      def reload_time;		31					end
      def bullet_class;		Rocket					end
    end
    
    # EliteRocketTower is the upgraded RocketTower
    class EliteRocketTower < RocketTower
      def image;		"images/towers/eliterocket.png"		end
      def image_size;		[40,40]					end
      def name;			"Elite Rocket Tower"			end
      def cost;			65					end
      def damage;		15					end
      def range;		3.8					end
      def reload_time;		20					end
      def bullet_class;		Rocket					end
    end
    
    # FreezingTower makes the opponents move slower
    class FreezingTower < Model::Tower
      def image;		"images/towers/freezing.png"		end
      def image_size;		[40,40]					end
      def name;			"Freezing Tower"			end
      def cost;			65					end
      def damage;		15					end
      def range;		1.8					end
      def reload_time;		15					end
      def bullet_class;		IceBullet				end
    end
    
    # EliteFreezingTower shots faster and has a better range
    class EliteFreezingTower < FreezingTower
      def image;		"images/towers/elitefreezing.png"	end
      def image_size;		[40,40]					end
      def name;			"Elite Freezing Tower"			end
      def cost;			65					end
      def damage;		15					end
      def range;		2.1					end
      def reload_time;		12					end
      def bullet_class;		IceBullet				end
    end
  end
end