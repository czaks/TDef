require "config"
module TDef::Model
  # Wave class - controls the coming of the monsters.
  class Wave
    def initialize
    end
    
    # Number of the current wave
    def number
    end
    
    # Starts a new wave (warning: creates a new thread) 
    def start_next
    end
    
    # Pointer to the thread used by Wave module or nil if it's not up.
    attr_reader :thread
    
    # The counter being modified by the Game thread.
    attr_accessor :time_to_next_wave
    
  private
    # Next monsters to appear - a random function.
    def monsters
    end
  end
end