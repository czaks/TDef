module TDef
  # Static configuration of TDef. Not to be modified by user.
  # @final
  class Config
    class << self
      #########
      # Video #
      #########
      
      # Screen resolution.
      def resolution;		[800, 600]			end
      
      # Grid dimensions.
      def map_size;		[12, 11]			end
      
      
      ############
      # Gameplay #
      ############
      
      # Monsters starting location
      def monsters_start_at;	[0, map_size[1]/2]		end
      
      # Monsters starting location
      def monsters_end_at;	[map_size[0]-1, map_size[1]/2]	end
      
      # Time to sleep between cycles. In seconds. Obviously,
      # the computer is running faster when it's set to a
      # lower value.
      def sleep_between_cycles;	0.02				end
      
      # The amount of money you get at the start of the game.
      def money_at_start;	250				end
      
      # The lifes at the start of the game (you can lose lifes
      # by letting the monsters getting out of the grid)
      def lifes_at_start;	15				end
      
      # Wavepoints are the points that are exchanged for...
      # monsters that keep coming to your base. For instance
      # 5 wavepoints can allow 5 monsters with wavecost 1 come
      # to your grid, or 2 monsters with wavecost 2 and 1 with
      # 1. This is the starting wavepoints setting.
      def wavepoints_at_start;	5				end
      
      # Every next wave would increase that number by...
      def wavepoints_increase;	2				end
      
      
      ###############
      # File config #
      ###############
      
      # Background image of the grid.
      def background_image;	"images/bgimg.png"		end
    end
  end
end