require "config"
require "model/monster"

class Array
  def sample
    self[rand size]
  end
end

module TDef
  module Model
    # Wave class - controls the coming of the monsters.
    class Wave
      def initialize
	@threads = []
	@number = 0
	@last_wave_ended = true
	
	threads << Thread.new do
	  loop do
	    break unless Game.running?
	    start_next if !Game.paused? and @last_wave_ended and Game.scene.monsters.size == 0
	    sleep 0.5
	  end
	end
      end
      
      # Number of the current wave
      attr_reader :number
      
      # Has the last wave already ended?
      attr_reader :last_wave_ended
      
      # Starts a new wave (warning: creates a new thread) 
      def start_next
	@last_wave_ended = false
	@number += 1
	@current_monsters = monsters
	
	threads << Thread.new do
	  loop do
	    sleep Config.push_monster_every
	    break unless Game.running?
	    next if Game.paused?
	    break if @current_monsters.size == 0
	    
	    Game.scene.create_monster @current_monsters.pop
	  end
	  @last_wave_ended = true
	end
      end
      
      # Pointers to the threads used by Wave module.
      attr_reader :threads
      
      # The counter being modified by the Game thread.
      attr_accessor :time_to_next_wave
      
    private
      # Next monsters to appear - a random function.
      def monsters
	wp = Config.wavepoints_at_start + Config.wavepoints_increase * (number - 1)
	
	allmons = Monster.get_all.delete_if { |i| i.new.min_wave < number or i.new.wavecost > wp }
	sending = []
	
	while allmons.size > 0
	  m = allmons.sample
	  sending << m
	  wp -= m.new.wavecost
	  allmons.delete_if { |i| i.new.wavecost > wp }
	end

	sending
      end
    end
  end
end