require "config"
require "rubygems"
require "sdl"

module TDef
  module View
    # Abstract, extensible class controlling screen and peripherials using
    # Ruby/SDL. Also, it initializes the SDL.
    # @abstract
    class Screen
      include Enumerable
      
      attr_accessor :active
      
      class << self
        # Initialize graphical subsystem
        def init
          SDL.init(SDL::INIT_VIDEO)
          self.handle = SDL.set_video_mode(Config.resolution[0], Config.resolution[1], 24, SDL::SWSURFACE)
          SDL::TTF.init
          self.font = SDL::TTF.open("images/ttf/DejaVuSans.ttf", 20, 0)
        end
        
        # Deinitialize graphical subsystem
        def deinit
          SDL.quit
        end
        
        attr_accessor :handle
        attr_accessor :font
      end
      
      def initialize
	@subscreens = []
        @active = true
        @thread = Thread.new do
          main_loop
        end
      end
        
      # Redraws the window by redrawing all the subscreens.
      def draw
	each do |i|
	  i.draw
	  SDL::Surface.blit(i.surface, 0, 0, i.size[0], i.size[1], Screen.handle, i.start[0], i.start[1])
	end
	
	Screen.handle.flip
      end
      
      # Main loop getting events from users
      def main_loop
        while is_active?
          single_step
        end
      end
      
      # Is the screen still active?
      def is_active?
        @active
      end
      
      # Thread of the graphical loop
      attr_reader :thread
      
    protected
      # Adds _subscreen_
      def add_subscreen(subscreen)
        subscreens << subscreen
        subscreen.parent_screen = self
      end
      
      # Removes a subscreen.
      def remove_subscreen(subscreen)
        subscreens -= [subscreen]
      end
      
      # Get subscreen of this screen with id in brackets.
      def [](index)
        subscreens[index]
      end
      
      # Iterate over the subscreens. We are now able to use most of the
      # *Enumerable* functions.
      def each(&block)
        @subscreens.each &block
      end

      # Waits for SDL events and returns [subscreen, sdl_event] pair, where
      # _subscreen_ is _nil_ if cursor is not at any subscreen. Default
      # implementation also sends the event to the subscreen.
      def get_event
        if e = _get_event
          case e
          when SDL::Event::MouseMotion, SDL::Event::MouseButtonUp
            k = [e.x, e.y]
            each do |ss|
              if ss.start[0] <= k[0] and ss.start[1] <= k[1] and ss.start[0] + ss.size[0] > k[0] and ss.start[1] + ss.size[1] > k[1]
                ss.handle_event([k[0] - ss.start[0], k[1] - ss.start[1]], e.class == SDL::Event::MouseButtonUp)
              end
            end
          end
        end
	                
	e
      end
      
    private
      # Overloadable single step.
      # @virtual
      def single_step
	get_event
      end
      
      # Internal function used by get_event. Doesn't broadcast to subscreens.
      # Do not use, unless overloading.
      def _get_event
        SDL::Event2.poll
      end
      
      attr_reader :subscreens
    end
  end
end
    