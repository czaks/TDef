require "config"
module TDef::Model
  # *HighScores* module with autosaving to file.
  class HighScores
    class << self
      include Enumerable
      
      # Get the place at the list you would get if you had _score_ points.
      def get_place(score)
      end
      
      # Save your _name_ with your _score_ to the *HighScores* list
      def insert(name, score)
      end
      
      # Iterate over the scores
      def each(&block)
        load
        @scores.each &block
      end
      
    private
      # Load file - done implicitly
      def load
      end
      
      # Save file - done implicitly
      def save
      end
    end
  end
end