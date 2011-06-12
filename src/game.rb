require "player"
require "config"
require "model/wave"
require "scene"
require "view/screen"
require "view/gamescreen"
require "thread"

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
      
      # A *Screen* class instance
      attr_reader :screen
        
      # Initialize game classes and SDL
      def init
        View::Screen.init
        replace_screen View::GameScreen
        @player = nil
        @screen = nil
        @wave = nil
        @scene = nil
	
	@moving = Mutex.new
      end
        
      # Quit the whole program.
      def deinit
        View::Screen.deinit
      end

      # Change screen to another (eg. *GameScreen*, or nil)
      def replace_screen(screen_class)
        @screen.active = false if @screen
        @screen = screen_class.new
      end

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
        @running = true
	@paused = false
	
        @player = Player.new
	@scene = Scene.new
        @wave = Model::Wave.new
	replace_screen View::GameScreen
      end

      # Unpauses, when it's paused
      def unpause
        @paused = false
	Game.screen.draw
      end
      
      # Pauses, when it's unpaused
      def pause
        @paused = true
	Game.screen.draw
      end
        
      # Stops the game
      def stop
        @running = false
        @wave = nil
        @scene = nil
        #Game.replace_screen View::EndGameScreen
        exit 0
      end
      
      def main_loop
        loop do
          if @running and !@paused
            single_step
          end
          sleep Config.sleep_between_cycles
        end
      end
      
      attr_accessor :moving
        
    private
      def single_step
        @scene.towers.each { |i,j| j.move }
        @scene.bullets.each { |i| i.move }
	moving.synchronize do
	  @scene.monsters.each { |i| i.move }
        end
	
	@screen.draw
      end
    end
  end
end
