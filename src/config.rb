module TDef
  # Static configuration of TDef. Not to be modified by user.
  # @final
  class Config
    class << self
      #########
      # Video #
      #########
      
      # Screen resolution.
      attr_reader :resolution
      @resolution = [800, 600]
      
      # Grid dimensions.
      attr_reader :map_size
      @map_size = [17, 15]
      
      
      ############
      # Gameplay #
      ############
      
      # Monsters starting location
      attr_reader :monsters_start_at
      @monsters_start_at = [0, map_size[1]/2]
      
      # Monsters starting location
      attr_reader :monsters_end_at
      @monsters_start_at = [map_size[0]-1, map_size[1]/2]
      
      # Time to sleep between cycles. In seconds. Obviously,
      # the computer is running faster when it's set to a
      # lower value.
      attr_reader :sleep_between_cycles
      @sleep_between_cycles = 0.02
      
      # The amount of money you get at the start of the game.
      attr_reader :money_at_start
      @money_at_start = 250
      
      # The lifes at the start of the game (you can lose lifes
      # by letting the monsters getting out of the grid)
      attr_reader :lifes_at_start
      @lifes_at_start = 15
      
      # Wavepoints are the points that are exchanged for...
      # monsters that keep coming to your base. For instance
      # 5 wavepoints can allow 5 monsters with wavecost 1 come
      # to your grid, or 2 monsters with wavecost 2 and 1 with
      # 1. This is the starting wavepoints setting.
      attr_reader :wavepoints_at_start
      @wavepoints_at_start = 5
      
      # Every next wave would increase that number by...
      attr_reater :wavepoints_increase
      @wavepoints_increase = 2
      
      
      ###############
      # File config #
      ###############
      
      # Background image of the grid.
      attr_reader :background_image
      @background_image = "images/bgimg.png"
      
      # Highscore file.
      attr_reader :highscore_file
      @highscore_file = "data/highscore.dat"
    end
  end
end