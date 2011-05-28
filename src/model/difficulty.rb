require "config"
module TDef::Model
  # Difficulty module - balances the difficulty for the players.
  # Usage: Game.difficulty.start_money(Config.start_money)
  # You can configure it using blocks like this:
  # @config[:start_money] = proc { |i| i*4 }
  class Difficulty
    # 0 is easy, 1 is medium, 2 is hard - loads the wanted _level_.
    def initialize(level)
      change level
    end
    
    # Changes level
    def change(level)
    end
    
    # Returns a word for "easy", "normal" and "hard"
    def to_s
    end
    
    # Used to facilitate the use like the following:
    # Game.difficulty.start_money(Config.start_money)
    def method_missing(trait, *args)
    end
    
  private
    # Configuration of the difficulty modes.
    def config
    end
  end
end