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
      
      class << self
        # Initialize graphical subsystem
        def init
          SDL.init(SDL::INIT_VIDEO)
          SDL.set_video_mode(Config.resolution[0], Config.resolution[1], 0, SDL::DOUBLEBUF)
        end
        
        # Deinitialize graphical subsystem
        def deinit
          SDL.quit
        end
      end
      
      def initialize
        Thread.new do
          main_loop
        end
      end
        
      # Redraws the window by redrawing all the subscreens.
      def draw
      end
      
      # Main loop getting events from users
      def main_loop
      end
      
      # Is the screen still active?
      def is_active?
        @active
      end
      
      # Thread of the graphical loop
      attr_reader :thread
      
    protected
      # Adds _subscreen_ starting at _from_ (pair of pixel coordinates)
      # having _size_ (also pair) pixels of width and height.
      def add_subscreen(subscreen, from, size)
      end
      
      # Removes a subscreen.
      def remove_subscreen(subscreen)
      end
      
      # Get subscreen of this screen with id in brackets.
      def [](index)
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
      end
      
    private
      # Overloadable single step.
      # @virtual
      def single_step
      end
      
      # Internal function used by get_event. Doesn't broadcast to subscreens.
      # Do not use, unless overloading.
      def _get_event
      end
    
      attr_reader :subscreens
    end
  end
end
    