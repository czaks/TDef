module TDef
  module View
    class Image
      class << self
	def draw(filename, dest, x, y)
	  @images ||= {}
	  @images[filename] = SDL::Surface.load(filename)
	  
	  SDL::Surface.blit(@images[filename], 0, 0, 0, 0, dest, x, y)
	end
      end
    end
  end
end