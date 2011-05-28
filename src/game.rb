require "player"
require "config"
require "model/wave"
require "scene"
require "model/difficulty"
require "view/screen"

module TDef
  # Static, final class. Includes main game logic.
  # @final
  class Game
    class << self
      # A *Player* class instance.
      attr_reader :player
      
      # A *Wave* class instance.
      attr_reader :wave
      
      # A *Scene* class instance
      attr_reader :scene
      
      # A *Difficulty* class instance
      attr_reader :difficulty
      
      # A *Screen* class instance
      attr_reader :screen
	
      # Initialize game classes and SDL
      def init
	View::Screen.init
	
	@player = Player.new
	@screen = View::Screen.new
	@wave = Model::Wave.new
	@difficulty = Model::Difficulty.new(1)
	@scene = Scene.new
      end
	
      # Quit the whole program.
      def deinit
	Screen.deinit
      end

      # Change screen to another (eg. *GameScreen*, or nil)
      def replace_screen(screen_class); end

      # Is the game running now?
      def running?
	@running
      end

      # Is the game paused now?
      def paused?
	@paused
      end
	
      # Starts the game
      def start
	@running = 1
      end

      # Unpauses, when it's paused
      def unpause
	@paused = 0
      end
	
      # Pauses, when it's unpaused
      def pause
	@paused = 1
      end
	
      # Stops the game
      def stop
	@running = 0
      end

	  
      def main_loop
	loop do
	  if @running and !@paused
	    single_step
	  end
	  sleep Config.sleep_between_cycles
	end
      end
	
    private
      def single_step; end
	
      # Game-oriented thread (running main loop) or nil if there's none
      attr_reader :thread
    end
  end
end
